class HomesController < ApplicationController

   def top
      @user = current_user #必要なのか不明
   end

   def about
   end

end
