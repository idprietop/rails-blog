require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before do
    @user = User.create(username: 'ivan', password: '123')
    @article = Article.create(title: 'Article test',
                              body: 'new article test',
                              status: 'public',
                              user_id: @user.id)
    session[:user_id] = @user.id
  end

  describe 'GET index' do
    subject { get :index }

    it 'Successful response and render index template ' do
      expect(subject).to have_http_status(200)
      expect(subject).to render_template('index')
    end
  end

  describe 'GET show' do
    subject { get(:show, params: { id: @article.id }) }

    it 'Successful response and render show template' do
      expect(subject).to have_http_status(200)
      expect(subject).to render_template('show')
    end
  end

  describe 'GET new' do
    subject { get(:new) }

    it 'Successful response and render new template' do
      expect(subject).to render_template('new')
    end
  end

  describe 'POST create' do
    subject do
      post :create,
           params: {
             article:
               { title: 'new title test',
                 body: 'new body test',
                 status: 'public',
                 user_id: @user.id }
           }
    end

    it 'New article successfully created' do
      expect(subject).to have_http_status(302)
      expect(Article.count).to eq(2)
    end
  end

  describe 'GET edit' do
    subject { get :edit, params: { id: @article.id } }

    it 'Successful response and render edit template' do
      expect(subject).to have_http_status(200)
      expect(subject).to render_template('edit')
    end
  end

  describe 'PUT update' do
    subject do
      put :update,
          params: {
            id: @article.id,
            article:
                  { title: 'Update test title',
                    body: 'Update test body',
                    status: 'public',
                    user_id: @user.id }
          }
    end
    it 'Existing article has edited successfully' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(@article)
    end
  end

  describe 'DELETE destroy' do
    subject do
      post :destroy,
           params: {
             id: @article.id
           }
    end

    it 'Existing article has removed successfully' do
      expect(subject).to have_http_status(302)
      expect(subject).to redirect_to(articles_path)
    end
  end
end
