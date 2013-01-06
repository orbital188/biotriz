def populate(table, data)
  data.each do |row|
    table.create! row
  end
end

def populate_hierarchical(table, data, parent_id=nil)
  data.each do |row|
    children = row.delete :children
    row[:parent_id] = parent_id
    record = table.create! row
    populate_hierarchical table, children, record.id
  end
end

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

    populate Size, sizes

    environments = [
      { title: 'Solid', description: 'Sub-surface ecosystems; rockes, lithosphere',
        children: [
          { title: 'Balk solid', description: '', children: [] },
          { title: 'Granulated', description: '', children: [] },
          { title: 'Powder', description: '', children: [] },
          { title: 'Reticulated substrate', description: 'Basket-like network', children: [] },
          { title: 'Fibrouse', description: 'Wood', children: [] },
          { title: 'Composite', description: 'Play-wood, paper', children: [] },
          { title: 'Fabric', description: '', children: [] },
          { title: 'Uniform', description: '', children: [] },
          { title: 'None-uniform', description: 'The same material or with inclusions', children: [] },
          { title: 'Durable', description: '', children: [] },
          { title: 'Temporal', description: '', children: [] },
          { title: 'Static', description: '', children: [] },
          { title: 'Moving', description: '', children: [] }
        ]
      },
      { title: 'Liquid', description: '',
        children: [
          { title: 'Gell', description: '', children: [] },
          { title: 'Fluid', description: '', children: [
              { title: 'Stream', description: "Laminar, turbulent, monotonous pulsating.\n\nTerminology to look for in biology: Autopotamic   Organisms", children: [] },
              { title: 'Still/stagnated', description: '', children: [] }
            ]
          },
          { title: 'Vapor', description: '', children: [] },
          { title: 'Pure/Compound liquid', description: '', children: [] },
          { title: 'With inclusions', description: 'Physical, Chemical, both.', children: [] },
          { title: 'Transparent', description: '', children: [] },
          { title: 'Opaque', description: '', children: [] },
          { title: 'Duration of existence: short', description: '', children: [] },
          { title: 'Duration of existence: long lasting', description: '', children: [] }
        ]
      },
      { title: 'Solid-liquid interface', description: '', children: [] },
      { title: 'Solid-gas interface', description: '',
        children: [
          { title: 'Dusty', description: '', children: [] }
        ]
      },
      { title: 'Solid-liquid-gas interface', description: '', children: [] },
      { title: 'Liquid-gas interface', description: '',
        children: [
          { title: 'Aerosols', description: '', children: [] }
        ]
      },
      { title: 'Gas', description: '',
        children: [
          { title: 'Still', description: '', children: [] },
          { title: 'Dynamic', description: 'Laminar, turbulent, monotonous pulsating, streamed or still.', children: [] },
          { title: 'Void', description: '',
            children: [
              { title: 'Permanent and static', description: '', children: [] },
              { title: 'Temporal and dynamic', description: '', children: [] }
            ]
          }
        ]
      },
    ]

    populate_hierarchical Environment, environments
  end
end
