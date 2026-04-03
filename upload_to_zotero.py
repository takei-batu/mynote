import os
from pyzotero import zotero

# 1. 環境変数から認証情報を取得
library_id = os.environ['ZOTERO_USER_ID']
api_key = os.environ['ZOTERO_API_KEY']
library_type = 'user' # 個人ライブラリを指定

collection_key = "XF2ZCLJG"

# Zoteroクライアントの初期化
zot = zotero.Zotero(library_id, library_type, api_key)

pdf_path = 'output.pdf'
title = 'Typst Compile Result' # Zotero上で表示されるタイトル（適宜変更してください）

print("Zoteroに親アイテム（文献データ）を作成中...")
# ドキュメント型の空アイテムを作成
template = zot.item_template('document')
template['title'] = title
template['collections'] = [collection_key]

resp = zot.create_items([template])

# 作成したアイテムのIDを取得
parent_id = resp['successful']['0']['key']
print(f"親アイテム作成完了 (ID: {parent_id})")

print("PDFをアップロードして添付中...")
# 対象のPDFを、先ほど作成した親アイテムに添付
zot.attachment_simple([pdf_path], parent_id)

print("✅ Zoteroへの登録とPDFアップロードが完了しました！")