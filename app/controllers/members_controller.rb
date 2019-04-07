class MembersController < ApplicationController
  def index
    #検索
    @members = Member.order :yomi
  end
  
  def show
    @member = find_member_by_id
  end

  def new
    #Memberクラス作成
    @member = Member.new
  end
  
  def create
    @member = Member.new(member_params)
    if @member.save
      #登録成功
      redirect_to_by(path: members_path, message: "#{@member.name}の連絡先を登録しました")
    else
      #登録失敗
      render action: :new
    end
  end
  
  def edit
    #条件付き検索
    @member = find_member_by_id
  end
  
  def update
    #条件付き検索
    @member = find_member_by_id
    #更新処理
    if @member.update(member_params)
      #更新成功
      redirect_to_by(path: members_path, message: "#{@member.name}の連絡先を更新しました")
    else
      #更新失敗
      render action: :edit
    end
  end
  
  def destroy
    #条件付き検索
    @member = find_member_by_id
    #削除
    @member.destroy
    redirect_to_by(path: members_path, message: "#{@member.name}の連絡先を削除しました")
  end
  
  private
  def member_params
    params.require(:member).permit(:name, :yomi, :phone)
  end
  
  def find_member_by_id
    Member.find(params[:id])
  end

  def redirect_to_by(path:, message:)
    redirect_to path, notice: message

    # redirect_to だと第二引数はnotice:, alert:を指定できる
    # それ以外を指定する場合　redirect_to path, flash: {key: "message"}
  end
end
