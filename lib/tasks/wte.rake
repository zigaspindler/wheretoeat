namespace :wte do
  desc "Creates new user"
  task :create_user, [:name] => :environment do |t, args|
    if args.nil? or args.empty?
      puts 'Missing name!'
    else
      name = args[:name]
      user = User.new username: name, password: '12345678', email: "#{name}@wheretoeat.com"
      user.save
      puts 'User created!'
    end
  end

end
