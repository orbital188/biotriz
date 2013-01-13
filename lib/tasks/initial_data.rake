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
      {title: 'Substance', description: "-	 What is it, what is it made of, contain, what does it produce or have?  Physical properties of matter (mass, volume, weight/pressure, density, plasticity, elasticity, colour, transparency, temperature; solid, liquid, gas, plasma, field; void etc.), chemical parameters (class of substance, etc.)\nUse, add/remove; compose/decompose/dissolve homogenize/distinguish; make inert/conductive; make resilient/flexible ; melt, freeze, evaporate, crystallize, sublimate, solidify, condense, congeal/clot, embed/absorb, substitute.\n\n-	Who? - All the standard police questions (e.g., name, surname, sex, age, address, employment, etc) and also: cultural and religious background, educational level, previous history, family status, list of relatives and close friends/regular contacts, medical/health state, psychological \"portrait\" (habits, preferences, hobbies, etc.)", children: [
        {title: 'Weight', description: "", children: []},
        {title: 'Mass', description: "", children: []},
        {title: 'Dencity', description: "", children: []},
        {title: 'Solubility', description: "", children: []},
        {title: 'Permeability', description: "", children: []} ,
        {title: 'Absorption', description: "", children: []},
        {title: 'Brittleness', description: "", children: []},
        {title: 'Opacity', description: "", children: []},
        {title: 'Transparancy', description: "", children: []},
        {title: 'Colour', description: "", children: []},
        {title: 'Concentration', description: "", children: []},
        {title: 'Dielectric properties', description: "", children: []},
        {title: 'Ductility', description: "", children: []},
        {title: 'Elasticity', description: "", children: []},
        {title: 'Adhesive properties', description: "", children: []},
        {title: 'Odor', description: "", children: []},
        {title: 'Taste', description: "", children: []},
        {title: 'Electrical conductivity', description: "", children: []},
        {title: 'Osmosis', description: "", children: []},
        {title: 'Flexibility', description: "", children: []},
        {title: 'Emission', description: "", children: []},
        {title: 'Luminance', description: "", children: []},
        {title: 'Fluidity', description: "", children: []},
        {title: 'Hardness', description: "", children: []},
        {title: 'Plasticity', description: "", children: []},
        {title: 'Luster', description: "", children: []},
        {title: 'Melting point', description: "", children: []},
        {title: 'Boiling point', description: "", children: []},
        {title: 'Radiance', description: "", children: []},
        {title: 'Quantity of substance', description: "increase, decrease or  distribute", children: []},
        {title: 'Viscosity', description: "", children: []}] },
      {title: 'Space', description: "-	 What is it, what is it made of, contain, what does it produce or have?  Physical properties of matter (mass, volume, weight/pressure, density, plasticity, elasticity, colour, transparency, temperature; solid, liquid, gas, plasma, field; void etc.), chemical parameters (class of substance, etc.)\r\nUse, add/remove; compose/decompose/dissolve homogenize/distinguish; make inert/conductive; make resilient/flexible ; melt, freeze, evaporate, crystallize, sublimate, solidify, condense, congeal/clot, embed/absorb, substitute.\r\n\r\n-	Who? - All the standard police questions (e.g., name, surname, sex, age, address, employment, etc) and also: cultural and religious background, educational level, previous history, family status, list of relatives and close friends/regular contacts, medical/health state, psychological вЂњportraitвЂќ (habits, preferences, hobbies, etc.)", children: [
          {title: 'Length', description: "", children: []},
          {title: 'Area', description: "", children: []},
          {title: 'Volume', description: "", children: []},
          {title: 'Location', description: "", children: []},
          {title: 'Distribution', description: "", children: []},
          {title: 'Capacitance', description: "", children: []},
          {title: 'Shape', description: "", children: []} ]},
      {title: 'Time', description: "-	When & how often & how does it change over time? Long or short term change, immediate change, postponed change, regular change: past, present, future, duration.\r\n\r\nModify the speed (retardation/ acceleration) of the process, or change an order or rhythm of the actions. Continue/periodic, synchronous/asynchronous/metachronous processes, fast/slow, regular/irregular, past-action/preliminary action.	Singular event (unique or not unique) or multiple event (irregular or regular: monotonouse,  routine work, waiting mode, frequency of cycles)\r\n	Special cases like: weekends, holidays, traditional periods of relaxation (night sleep, siesta, etc.), time for prays, special events, etc.\r\n-	Shifts (day and night)\r\n-	Deadlines.", children: [
          {title: 'Duration', description: "", children: []},
          {title: 'Rate', description: "", children: []},
          {title: 'Frequency', description: "", children: []},
          {title: 'Momentum', description: "", children: []},
          {title: 'Velocity', description: "", children: []},
          {title: 'Delay', description: "", children: []},
          {title: 'Retardation', description: "", children: []},
          {title: 'Acceleration', description: "", children: []},
          {title: 'Productivity', description: "", children: []},
          {title: 'Force', description: "", children: []} ]},
      {title: 'Structure', description: "- How is it structured? What are its components? \r\n- What is it connected by and how? \r\n- How is it supported?\r\n\r\nStructure can be:\r\n-	irregular\r\n-	regular: hierarchical, fractal, homogenous or with gradient of features\r\n-	standard , compatible, inter-changeable, modular (of the same scale - e.g. LEGO and different scales - e.g. LEGO + DUPLO)\r\n-	Physical structure (monolithic or fragmented, with internal cavities and their structures, surface texture, combination of various items, objects, materials), regularity of the structure - random, regular; natural, artificial; etc\r\n-	Organizational structure\r\n-	Temporal structure\r\n-	Energy structure\r\n-	Informational structure\r\n", children: [
          {title: 'Composition', description: "", children: []},
          {title: 'Stiffness', description: "", children: []},
          {title: 'Complexity', description: "", children: []},
          {title: 'Degree of freedom', description: "", children: []},
          {title: 'Network structure', description: "", children: []},
          {title: 'Hierarchical structure', description: "", children: []},
          {title: 'Fractal structure', description: "", children: []} ]},
      {title: 'Energy/Field', description: "-  What is the driver? Why it all works? What energy does it use? How does energy affect the process/object? \r\nMake it inert/conductive. Change energy source or type of acting field (gravity, sunlight, geo-magnetic, electric, acoustic, heat, illumination, pressure). Long-life/expensive/short-life/cheap.\r\n\r\nEnergy types , e.g. potential, kinetic.\r\nChemical energy (energy of chemical bonds - various fuels, explosives)\r\nDuration of energy action: short (explosion, implosion, collapse, flight of a bullet, sparkle, etc.) or long (flood, volcano eruption, fire in a forest, etc.). \r\n\r\nPossible parameters to describe: power, dynamics/statics, duration, force, tension.\r\n\r\nBeneficial high-energy processes (e.g. hydro-power station, diesel engine) and negative high-energy processes (e.g. forest fire, earth-quake, flood, de-railing of a train, collapse of a bridge, etc.).\r\n\r\nMetaphoric manifestation. Finances and money: income and spending, cost, price, turn-over, cash and virtual money, commodities - gold, silver, platinum and other precious and rare metals and stones, etc.\r\n\r\nPsychological/sociological/political/religious вЂњenergyвЂќ - charisma, passionaruty, popularity of a person among other people (positive or negative), etc.", children: [
          {title: 'Gravity', description: "", children: []},
          {title: 'Elastic Force Internal & External', description: "", children: []},
          {title: 'Power', description: "", children: []},
          {title: 'Strength', description: "", children: []},
          {title: 'Pressure', description: "", children: []},
          {title: 'Friction', description: "", children: []},
          {title: 'Moment', description: "", children: []},
          {title: 'Tension', description: "", children: []},
          {title: 'Centrifugal Force', description: "", children: []},
          {title: 'Inertia of Bodies', description: "", children: []},
          {title: 'Coriolis Force', description: "", children: []},
          {title: 'Buoyant force', description: "", children: []},
          {title: 'Hydrostatic Pressure', description: "", children: []},
          {title: 'Jet Pressure', description: "", children: []},
          {title: 'Surface Tension', description: "", children: []},
          {title: 'Freezing', description: "", children: []},
          {title: 'Heating', description: "", children: []},
          {title: 'Chemical energy', description: "", children: []},
          {title: 'Sound/Wave', description: "", children: []},
          {title: 'Vibrations & Oscillations', description: "", children: []},
          {title: 'Ultrasound', description: "", children: []},
          {title: 'Luminescence', description: "", children: []},
          {title: 'light (visible, infrared, ultraviolet)', description: "", children: []},
          {title: 'X-Ray, radiation', description: "", children: []},
          {title: 'Radio Waves', description: "", children: []},
          {title: 'Corona Discharge', description: "", children: []},
          {title: 'Electrostatic Field', description: "", children: []},
          {title: 'Magnetic Field', description: "", children: []},
          {title: 'Electromagnetic (Voltage)', description: "", children: []},
          {title: 'Current', description: "", children: []},
          {title: 'Eddie Currents (internal and skin)', description: "", children: []},
          {title: 'Particle Beams', description: "", children: []},
          {title: 'Irradiance', description: "", children: []},
          {title: 'Nuclear Forces', description: "", children: []},
          {title: 'Intensity', description: "", children: []} ]},
      {title: 'Information', description: "- What is it for? How it works? How information is processed & controlled? \r\n\r\nUse or modify the regulation, information exchange, detecting, measuring, adapting issues, positive and negative feed-back and feed-forward. Camouflage, mimicry; hide, cover, watch, patrol, dominate.\r\n\r\nThermodynamic information/entropy\r\nChaos/chaos in any system/society (under normal and abnormal conditions)\r\nInformation and reliability\r\nInformation and theory of catastrophes\r\n\r\nвЂњInformationalвЂќ information.Strict/flexible programs (make it standard, regulate), hierarchy, stability/adaptability. Affect knowledge, experience, attitudes, feelings.\r\n-	Communication: positive and negative sides\r\n-	Descriptive (laws) and prescriptive information (rules)\r\n-	Information flows in large systems (up- and down-flows)\r\n-	Horizontal transfer of information.\r\n-	Networks\r\n-	Flash-mobs\r\n-	Crowd-sourcing\r\n-	Camouflage, mimicry, deception\r\n-	Psychological вЂњinfectionsвЂќ\r\n-	Hypnosis/suggestion, NLP.", children: [
          {title: 'Detection', description: "", children: []},
          {title: 'Precision', description: "", children: []},
          {title: 'Convenience of use', description: "", children: []},
          {title: 'Adaptability', description: "", children: []},
          {title: 'Reliability', description: "", children: []},
          {title: 'Regulation', description: "", children: []},
          {title: 'Evaluation', description: "", children: []},
          {title: 'Signals', description: "", children: []},
          {title: 'Context understanding', description: "", children: []},
          {title: 'Analysis', description: "", children: []},
          {title: 'Feedforward', description: "", children: []},
          {title: 'Memory', description: "", children: []},
          {title: 'Exchange of information', description: "", children: []},
          {title: 'Interaction', description: "", children: []},
          {title: 'Rules', description: "", children: []},
          {title: 'Procedures', description: "", children: []},
          {title: 'Grade', description: "", children: []} ]}
    ]

    populate_hierarchical Parameter, parameters
  end
end
