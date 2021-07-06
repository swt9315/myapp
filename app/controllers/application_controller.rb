class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

# サインアップ時に、ユーザーの名前を登録できるようにする
# Railsでは、悪意のあるユーザーの入力に対してセキュリティ対策を行わないと保存できない仕組みがあります。
# 通常のテーブルに保存する際はストロングパラメータを使用しましたが、deviseを使ったモデルの場合は方法が異なります。
# 上のコードは、deviseの公式サイトで紹介されている書き方です。そのまま使用するものという理解でも問題ありませんが、
# 簡単にコードの解説を行います。
# application_controllerにbefore_actionを使用しているため、全てのアクションが実行される前に、この部分が実行
# されることになります。deviseのコントローラーから呼び出された場合は、「configure_permitted_parameters」メソッドが呼ばれます。
# ここでconfigure_permitted_parametersの定義を行なっています。
# deviseをインストールすることでdevise_parameter_sanitizerのpermitメソッドが使えるようになりますが、
# これがストロングパラメータに該当する機能です。サインアップ時に入力された「name」キーの内容の保存を許可しています。

# 設定が終わったら、以下のURLにアクセスして正常にビューが表示されることを確認しましょう。
# http://localhost:3000/users/sign_up