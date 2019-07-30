module UserHelper
  private

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
