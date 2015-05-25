require 'dm-core'
require 'dm-migrations'

class Student
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :email, String
  property :gpa, String
end

configure do
  enable :sessions
  set :username, 'saumya'
  set :password, 'ruby'
end

DataMapper.finalize

get '/students' do
  @students = Student.all
  slim :students
end

get '/students/new' do
  @student = Student.new
  slim :add_student
end

get '/students/:id' do
  @student = Student.get(params[:id])
  slim :view_student
end

get '/students/:id/edit' do
  @student = Student.get(params[:id])
  slim :edit_student
end

post '/students' do  
  student = Student.create(params[:student])
  redirect to("/students/#{student.id}")
end

put '/students/:id' do
  student = Student.get(params[:id])
  student.update(params[:student])
  redirect to("/students/#{student.id}")
end

delete '/students/:id' do
  Student.get(params[:id]).destroy
  redirect to('/students')
end