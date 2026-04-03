import os
import sys
from pyzotero import zotero

# 認証情報
library_id = os.environ['ZOTERO_USER_ID']
api_key = os.environ['ZOTERO_API_KEY']
collection_key = '****' # あなたのコレクションキー

pdf_filename = os.environ.get('PDF_PATH', 'output.pdf')
title = os.environ.get('PDF_TITLE', 'Typst Note')

zot = zotero.Zotero(library_id, 'user', api_key)

# 1. 親アイテム（文献データ）の作成
template = zot.item_template('document')
template['title'] = title
template['collections'] = [collection_key]
resp = zot.create_items([template])
parent_id = resp['successful']['0']['key']

# 2. 添付ファイル用の「枠」だけを作成（実体は送らない）
att_template = zot.item_template('attachment', 'imported_file')
att_template['title'] = pdf_filename
att_template['filename'] = pdf_filename
# ここで空のアイテムとして登録
att_resp = zot.create_items([att_template], parentid=parent_id)
attachment_key = att_resp['successful']['0']['key']

# 3. 取得した8文字のキーをGitHub Actionsに渡す
env_file = os.getenv('GITHUB_OUTPUT')
with open(env_file, "a") as f:
    f.write(f"key={attachment_key}\n")

print(f"Success: Metadata created with Key {attachment_key}")