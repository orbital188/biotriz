# -*- coding: utf-8 -*-

$stdout.sync = true

def populate(table, data)
  print "Populate table #{table}... "

  new, ignored = 0, 0

  data.each do |row|
    if table.exists? row
      ignored += 1
    else
      table.create! row
      new += 1
    end
  end

  puts "Done (#{new} new record(s), #{ignored} ignored, #{table.count} total)"
end

def populate_hierarchical(table, data, parent_id=nil)
  print "Populate table #{table}... "

  new, ignored = 0, 0
  inc_new, inc_ignored = lambda { new += 1 }, lambda { ignored += 1 }

  def inner(table, data, parent_id, inc_new, inc_ignored)
    data.each do |row|
      children = row.delete :children

      dataset = if parent_id then table.find(parent_id).children else table end

      if dataset.exists? row
        inc_ignored.call
      else
        row[:parent_id] = parent_id
        record = table.create! row
        inc_new.call
        inner table, children, record.id, inc_new, inc_ignored
      end
    end
  end

  inner table, data, nil, inc_new, inc_ignored

  puts "Done (#{new} new record(s), #{ignored} ignored, #{table.count} total)"
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

    complexities = [
      { title: 'Molecule', description: '' },
      { title: 'Cell', description: '' },
      { title: 'Tissue', description: '' },
      { title: 'Organ', description: '' },
      { title: 'System of organs', description: '' },
      { title: 'Organism', description: '' },
      { title: 'Group', description: '' },
      { title: 'Population', description: '' },
      { title: 'Ecosystem', description: '' }
    ]

    populate Complexity, complexities

    parameters = [
      { title: 'Substance', description: "-	 What is it, what is it made of, contain, what does it produce or have?  Physical properties of matter (mass, volume, weight/pressure, density, plasticity, elasticity, colour, transparency, temperature; solid, liquid, gas, plasma, field; void etc.), chemical parameters (class of substance, etc.)\nUse, add/remove; compose/decompose/dissolve homogenize/distinguish; make inert/conductive; make resilient/flexible ; melt, freeze, evaporate, crystallize, sublimate, solidify, condense, congeal/clot, embed/absorb, substitute.\n\n-	Who? - All the standard police questions (e.g., name, surname, sex, age, address, employment, etc) and also: cultural and religious background, educational level, previous history, family status, list of relatives and close friends/regular contacts, medical/health state, psychological \"portrait\" (habits, preferences, hobbies, etc.)", children: [] }
    ]

    populate_hierarchical Parameter, parameters
  end
end
