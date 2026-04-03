import os
from pyzotero import zotero

# 1. 環境変数から認証情報を取得
library_id = os.environ['ZOTERO_USER_ID']
api_key = os.environ['ZOTERO_API_KEY']
library_type = 'user' # 個人ライブラリを指定

collection_key = "436E26CC"

pdf_path = os.environ.get('PDF_PATH', 'output.pdf')
title = os.environ.get('PDF_TITLE', 'Typst Compile Result')

zot = zotero.Zotero(library_id, 'user', api_key)

print(f"Zoteroに親アイテムを作成中... (タイトル: {title})")
template = zot.item_template('document')
template['title'] = title
template['collections'] = [collection_key]
resp = zot.create_items([template])
parent_id = resp['successful']['0']['key']

print("添付ファイルのデータ（枠組み）を作成中...")
# ファイル実体ではなく、Zotero上に「ファイル置き場の枠」だけを作ります
att_template = zot.item_template('attachment', 'imported_file')
att_template['title'] = pdf_path
att_template['filename'] = pdf_path

att_resp = zot.create_items([att_template], parentid=parent_id)
attachment_key = att_resp['successful']['0']['key']
print(f"添付ファイルの枠を作成完了 (ID: {attachment_key})")

# 追加：GitHub Actionsの次のステップにこのIDを渡す
env_file = os.getenv('GITHUB_ENV')
with open(env_file, "a") as f:
    f.write(f"ATTACHMENT_KEY={attachment_key}\n")