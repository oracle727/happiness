class ContactsController < ApplicationController

   def new
    @contact = Contact.new
   end

  # 確認画面を作成
  # newアクションから入力内容を受け取り
  # 送信ボタンを押されたらcreateアクションを実行
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  # 入力内容に誤りがあった場合、
  # 入力内容を保持したまま前のページに戻るが
  # backアクションを定義することで可能
  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.email = current_user.email
    if @contact.valid?
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      render :new
    end
  end

  # 送信完了画面を使用する
  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:email,:name, :message)
  end
end
