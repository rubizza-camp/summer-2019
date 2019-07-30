require_relative 'helper/user_module_helper'
require 'active_record'
require 'securerandom'
require 'date'
require 'time'

class User < ActiveRecord::Base
  has_many :feed_backs
  has_many :snack_bars

  validates :mail, uniqueness: true
  validates :password, confirmation: true, length: { in: 8..64 }, presence: true, on: :create

  extend UserHelper

  def update_snackbar_commnets_count_and_rait(post)
    current_snack_bar = SnackBar.find_by_id(post.params[:id])
    calculate_comments_count_and_rait(current_snack_bar, post)
  end

  private

  def calculate_comments_count_and_rait(current_snack_bar, post)
    current_comments_count = current_snack_bar.comments_count
    next_comments_count = current_comments_count ? current_comments_count + 1 : 1
    calculate_snackbar_modular_raiting(current_snack_bar, next_comments_count, post)
  end

  def calculate_snackbar_modular_raiting(current_snack_bar, next_comments_count, post)
    olt_raiting = current_snack_bar.modular_raiting ? current_snack_bar.modular_raiting.to_f : 0.0
    new_raiting = (post.params[:raiting].to_f + olt_raiting *
      (next_comments_count - 1)) / next_comments_count
    current_snack_bar.update_attribute(:modular_raiting, new_raiting)
    current_snack_bar.update_attribute(:comments_count, next_comments_count)
  end
end
