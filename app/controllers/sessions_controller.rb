class SessionsController < ApplicationController
    def create
        data = request.env['omniauth.auth']
        session[:user] = data.info
        session[:user][:uid] = data.uid
        redirect_to root_path, notice: 'ログインしました'
    end

    def destroy
        session[:user] = nil
        redirect_to root_path, notice: 'ログアウトしました'
    end

    def oauth_failure
        redirect_to root_path, notice: 'ログインに失敗しました'
    end
end
