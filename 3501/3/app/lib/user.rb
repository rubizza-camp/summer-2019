require_relative 'helper/user_module_helper'
require './app/lib/errors/user/user_errors'
require 'active_record'
require 'securerandom'
require 'date'
require 'time'
require 'bcrypt'

class User < ActiveRecord::Base
  extend UserAdditionalHelper

  has_many :feed_backs
  has_many :snack_bars

  validates :email, uniqueness: true
  validates_confirmation_of :password

  def update_snackbar_commnets_count_and_rait(post)
    current_snack_bar = SnackBar.find_by_id(post.params[:id])
    calculate_comments_count_and_rait(current_snack_bar, post)
  end

  private

  def calculate_comments_count_and_rait(current_snack_bar, post)
    current_comments_count = current_snack_bar.comments_count
    next_comments_count = current_comments_count ? current_comments_count + 1 : 1
    calculate_snackbar_modular_rating(current_snack_bar, next_comments_count, post)
  end

  def calculate_snackbar_modular_rating(current_snack_bar, next_comments_count, post)
    olt_rating = current_snack_bar.modular_rating ? current_snack_bar.modular_rating.to_f : 0.0
    new_rating = (post.params[:rating].to_f + olt_rating *
      (next_comments_count - 1)) / next_comments_count
    current_snack_bar.update_attribute(:modular_rating, new_rating)
    current_snack_bar.update_attribute(:comments_count, next_comments_count)
  end
end
