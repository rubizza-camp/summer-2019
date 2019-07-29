module DataConverter
  def self.convert_info_order(data)
    [data[:name], data[:used_by],
     data[:watchers], data[:stars],
     data[:forks], data[:contributors],
     data[:issues]]
  end
end
