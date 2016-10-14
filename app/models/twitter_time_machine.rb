class TwitterTimeMachine

  def self.tweet(date)
    # offset by the current day of the week

    # figure out which day is monday of this week
    # go back a year and get the previous week
    sql = <<~SQL
      select * from posts
        where created_at > date_trunc('week', '#{date}'::date)::date - 365 and
        created_at < date_trunc('week', '#{date}'::date)::date - 357
        order by likes desc
        offset extract(dow from timestamp '#{date}'::date) - 2
        limit 1;
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end
end
