#!/usr/bin/env python3
"""
upterm_client.py — macOS 実機 (upterm) との通信クライアント。
使い方:
  python3 upterm_client.py probe                       # 画面取得 (tmux の現画面を表示)
  python3 upterm_client.py send "command"              # コマンドを送信して実行画面を取得
  python3 upterm_client.py sftp-put <local> <remote>   # ファイル/ディレクトリをリモートへ送信
  python3 upterm_client.py sftp-get <remote> <local>   # ファイル/ディレクトリをリモートから取得
"""
import sys
import os
import time
import re
import paramiko
import pyte

USER = 'Xj883Vnbju9eSm6e6kbq'
HOST = 'uptermd.upterm.dev'
PORT = 22
KEY_FILE = '/home/user/.ssh/id_ed25519'

def get_client():
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    key_path = KEY_FILE if os.path.exists(KEY_FILE) else os.path.expanduser('~/.ssh/id_ed25519')
    if not os.path.exists(key_path):
        import subprocess
        os.makedirs(os.path.dirname(key_path), exist_ok=True)
        subprocess.run(['ssh-keygen', '-t', 'ed25519', '-N', '', '-f', key_path], check=True)
    client.connect(HOST, port=PORT, username=USER, key_filename=key_path)
    return client

class MyScreen(pyte.Screen):
    def __getattr__(self, name):
        return lambda *a, **kw: None

def render_screen(out_bytes):
    text = out_bytes.decode('utf-8', errors='replace')
    text = re.sub(r'\x1b\[[\?>][0-9;]*[a-zA-Z]', '', text)
    text = re.sub(r'\x1b\][0-9]+;[^\a\x1b]*(\a|\x1b\\\\)', '', text)
    screen = MyScreen(132, 43)
    stream = pyte.Stream(screen)
    stream.feed(text)
    lines = []
    for line in screen.display:
        if line.strip():
            lines.append(line.rstrip())
    return "\n".join(lines)

def do_probe(client, wait=1.5):
    chan = client.get_transport().open_session()
    chan.get_pty(term='xterm', width=132, height=43)
    chan.invoke_shell()
    time.sleep(wait)
    out = b''
    while chan.recv_ready():
        out += chan.recv(65536)
    chan.close()
    print(render_screen(out))

def do_send(client, cmd, wait=2.0):
    chan = client.get_transport().open_session()
    chan.get_pty(term='xterm', width=132, height=43)
    chan.invoke_shell()
    time.sleep(1.0)
    while chan.recv_ready():
        chan.recv(65536)
    chan.send(cmd + '\n')
    time.sleep(wait)
    out = b''
    while chan.recv_ready():
        out += chan.recv(65536)
    chan.close()
    print(render_screen(out))

def sftp_put_recursive(sftp, local_path, remote_path):
    if os.path.isfile(local_path):
        remote_dir = os.path.dirname(remote_path)
        if remote_dir:
            try:
                sftp.stat(remote_dir)
            except IOError:
                # mkdir -p equivalent
                parts = remote_dir.split('/')
                curr = ''
                for p in parts:
                    if not p:
                        curr += '/'
                        continue
                    curr = os.path.join(curr, p) if curr else p
                    try:
                        sftp.stat(curr)
                    except IOError:
                        sftp.mkdir(curr)
        sftp.put(local_path, remote_path)
        print(f"Uploaded file: {local_path} -> {remote_path}")
    elif os.path.isdir(local_path):
        try:
            sftp.stat(remote_path)
        except IOError:
            sftp.mkdir(remote_path)
        for item in os.listdir(local_path):
            sftp_put_recursive(sftp, os.path.join(local_path, item), os.path.join(remote_path, item))
        print(f"Uploaded directory: {local_path} -> {remote_path}")

def sftp_get_recursive(sftp, remote_path, local_path):
    import stat
    mode = sftp.stat(remote_path).st_mode
    if stat.S_ISDIR(mode):
        os.makedirs(local_path, exist_ok=True)
        for item in sftp.listdir(remote_path):
            sftp_get_recursive(sftp, os.path.join(remote_path, item), os.path.join(local_path, item))
        print(f"Downloaded directory: {remote_path} -> {local_path}")
    else:
        local_dir = os.path.dirname(local_path)
        if local_dir:
            os.makedirs(local_dir, exist_ok=True)
        sftp.get(remote_path, local_path)
        print(f"Downloaded file: {remote_path} -> {local_path}")

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    op = sys.argv[1]
    client = get_client()
    try:
        if op == 'probe':
            do_probe(client)
        elif op == 'send':
            cmd = " ".join(sys.argv[2:])
            do_send(client, cmd)
        elif op == 'sftp-put':
            sftp = client.open_sftp()
            sftp_put_recursive(sftp, sys.argv[2], sys.argv[3])
            sftp.close()
        elif op == 'sftp-get':
            sftp = client.open_sftp()
            sftp_get_recursive(sftp, sys.argv[2], sys.argv[3])
            sftp.close()
        else:
            print(f"Unknown operation: {op}")
            sys.exit(1)
    finally:
        client.close()

if __name__ == '__main__':
    main()
