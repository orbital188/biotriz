namespace :db do
  desc "Fill database with initial data"

  task populate: :environment do
    sizes = [
      { title: 'Nano-scale', description: 'Molecular interactions' },
      { title: 'Micro-scale', description: 'Cells' },
      { title: 'Millemetre', description: '' },
      { title: 'Centimetre', description: '' },
      { title: 'Metre', description: '' },
      { title: 'Kilometre', description: '' }
    ]

    sizes.each do |size|
      Size.create! title: size[:title], description: size[:description]
    end
  end
end
