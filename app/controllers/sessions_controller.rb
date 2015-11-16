class SessionsController < ApplicationController
    def create
        data = request.env['omniauth.auth']
        if Author.exists?(uid:data.uid)
          session[:user] = data.info
          session[:user][:uid] = data.uid
          redirect_to root_path, notice: 'ログインしました'
        else
          redirect_to root_path, alert: 'このアカウントは権限がありません'
        end
    end

    def destroy
        session[:user] = nil
        redirect_to root_path, notice: 'ログアウトしました'
    end

    def oauth_failure
        redirect_to root_path, alert: 'ログインに失敗しました'
    end
end
