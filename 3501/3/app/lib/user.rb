require_relative 'helper/user_module_helper'
require 'active_record'
require 'securerandom'
require 'date'
require 'time'

class User < ActiveRecord::Base
  class << self
    include UserHelper
  end

  has_many :feed_backs
  has_many :snack_bars

  # :reek:FeatureEnvy
  def create_new_snackbar(post) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    snack_bars.create(
      description: post.params[:description],
      name: post.params[:name],
      photo: post.params[:photo],
      telephone: post.params[:telephone],
      working_time_opening: post.params[:working_time_opening],
      working_time_closing: post.params[:working_time_closing],
      latitude: post.params[:latitude],
      longitude: post.params[:longitude]
    )
  rescue NoMethodError
    false
  end

  def create_new_comment(post)
    self_create_new_comment(post)
    current_snack_bar = SnackBar.find_by_id(post.params[:id])
    current_comments_count = current_snack_bar.comments_count
    update_snackbar_commnets_count_and_rait(current_snack_bar, current_comments_count, post)
  rescue NoMethodError
    false
  end

  private

  # :reek:FeatureEnvy
  def self_create_new_comment(post)
    feed_backs.create(
      snack_bar_id: post.params[:id],
      content: post.params[:content],
      raiting: post.params[:raiting],
      date: Time.now
    )
  end

  def update_snackbar_commnets_count_and_rait(current_snack_bar, current_comments_count, post)
    current_comments_count = current_comments_count ? current_comments_count + 1 : 1
    current_snack_bar.update_attribute(:comments_count, current_comments_count)
    update_snackbar_modular_raiting(current_snack_bar, current_comments_count, post)
  end

  def update_snackbar_modular_raiting(current_snack_bar, current_comments_count, post)
    olt_raiting = current_snack_bar.modular_raiting ? current_snack_bar.modular_raiting.to_f : 0.0
    new_raiting = (post.params[:raiting].to_f + olt_raiting *
      (current_comments_count - 1)) / current_comments_count
    current_snack_bar.update_attribute(:modular_raiting, new_raiting)
  end
end
