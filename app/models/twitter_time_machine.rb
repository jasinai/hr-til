class TwitterTimeMachine

  def self.find_daily_post(date)

    sql = <<~SQL
      select * from posts
        where created_at between date_trunc('week', ('#{date}'::timestamp - '1 year'::interval)) - '1 day'::interval
                          and date_trunc('week', ('#{date}'::timestamp - '1 year'::interval)) + '6 days'::interval
        order by likes desc
        offset date_part('dow', '#{date}'::date)
        limit 1;
    SQL

    Post.find_by_sql(sql).first
  end
end
