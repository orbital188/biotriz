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

    principles = [
        { title: 'Segmentation', description: "- Divide an object into independent parts\r\n- Make an object sectional\r\n- Increase the degree of fragmentation or segmentation.\r\n\r\nTechnology: The digging edge of excavator’s (digger’s) bucket is fragmented into separate parts and very often provided with teeth. If one tooth is broken, it can easily be replaced by the new one.\r\n\r\nBiology:The chewing edge of mammal’s mouth is divided into separate teeth: if one is broken or damaged the whole teeth row is still able to perform its function\r\n\r\nBio-camouflage: Segmentation of a familiar visual image by a disruptive colour pattern makes perception of the object sufficiently more difficult, e.g. stripes of a tiger among the reeds.",principle_number:'1' },
        { title: 'Taking out/extraction', description: "Extract the disturbing part  (or property) from an object\r\n\r\n Extract the only necessary part (or property) of an object\r\n\r\nAntennas are normally taken out and installed on the highest points - roofs, mountain tops.\r\n\r\nGuardian’s eyes and vision are “taken out” and extended with the help of CCTV cameras. The same is performed in the case of periscope of a submarine.\r\n\r\nMost of mushrooms that live in forests actually live under the ground and that what we see on the surface is a fruiting body, which function is only to produce and spread spores." ,principle_number:'2' },
        { title: 'Local Quality', description: "Change of an object’s structure from uniform to non-uniform\r\n\r\n Change an action or an external environment from uniform to non-uniform\r\n\r\n Make each part of an object to function in conditions most suitable for its operation\r\n\r\n Make each part of an object fulfil a different and/or complementary useful function\r\n\r\nMasonry drill bit is provided with the very hard cutting edge, meanwhile the rest of the drill is made of the softer sort of steel. The front teeth of rodents are self-sharpening due to the following structure: the front edge of tooth’s surface is very hard and the rear - soft, thus teeth stay always sharp.",principle_number:'3' },
        { title: 'Asymmetry', description: "Change the shape of an object from symmetrical to asymmetrical\r\n•	If an object is asymmetrical change the degree of asymmetry or consider the add asymmetry to its parts.\r\n•	Introduce asymmetry to function or process\r\n\r\nTechnology: Right or left position of a steering wheel in a car. \r\nSpecial scissors, pens and other tools for left-handed or right-handed operators.\r\n\r\nBiology: Internal morphological asymmetry of some of human organs - heart, liver, stomach, and functional asymmetry of left and right hands, ears as the result of functional asymmetry of left and right hemispheres of the brain.\r\n",principle_number:'4' },
        { title: 'Merging/Consolidation', description: "Bring closer together (or merge)  identical or similar objects or operations  in space\r\n•	Make objects or operations contiguous  or parallel.\r\n\r\nTechnology: Terrace-houses, a house with a garage, a house with a conservatori. Mobile phones and GPS, alarm clock and a torch.  \r\nBiology: Honey-bees’ comb, lichen  actually is co-habitation of a mushroom and algae.\r\n",principle_number:'5' },
        { title: 'Universality', description: "Make the object perform multiple functions\r\n•	Eliminate the need for other part \r\n•	Eliminate all idle or intermittent motion\r\n\r\nTechnology: Swiss Army knife, large shopping centre, alphabet, a brick.\r\nBiology: A human palm performs many functions; universality of DNA; basic processes of metabolism are universal for all living creatures. \r\n",principle_number:'6' },
        { title: 'Nested doll', description: "•	Place one object inside another\r\n•	Place multiple objects inside others\r\n•	Make one part  pass (dynamically) through a cavity of the other\r\n\r\nTechnology: Any telescopic system (antenna, fishing rod, extendable legs of tables and chairs, etc.); multi-layer systems (coating, isolation of co-axial cables, clothes, etc.)\r\nBiology: Bulb of onion and leaves of leak; abdomen of insects.\r\n",principle_number:'7' },
        { title: 'Anti-weight', description: "•	To compensate the weight of an object, merge it with other objects that provide lift\r\n•	To compensate the weight of an object, make it interact with the environment (use aerodynamic, aerostatic, hydrodynamic, hydrostatic,  buoyancy and other forces)\r\n\r\nTechnology: Any devices based on the effects of floatation (in gas and \r\nliquid) - inflated boat, hot-air balloon,  jet-foil; children’s toy see-saw; beam balance.\r\n\r\nBiology: Floatation of aquatic animals; any symmetry of most of animals is due to even distribution of weight, i.e. weight and anti-weight.\r\n",principle_number:'8' },
        { title: 'Preliminary anti-action', description: "•	When it is necessary to perform an action with both harmful and useful effects, this should be replaced with anti-actions to control harmful effects\r\n•	Create beforehand stresses in an object that will oppose known undesirable working stress later on.\r\n\r\nTechnology: Safety measures, warning signs and announcements.\r\nBiology: Protective structures and behaviour of different animals - spines, needles, shells, poisonous excretes; storage of nutrients as deposition of fat or food (honey in bees, nuts, grain, seeds of plants in rodents) for long winter period.\r\n",principle_number:'9' },
        { title: 'Preliminary action', description: "•	Perform the required change of an object in advance\r\n•	Pre-rearrange objects in such a way that they will come into action from the most convenient place and without losing time for their delivery\r\n\r\nTechnology: Any system that is pre-paid, pre-cooked, pre-cut, pre-stressed, pre-fabricated, pre-frozen, \r\npre-booked, pre-arranged. Any rehearsal, exercise, drill training of musical orchestra, sport-team, \r\nplay. \r\nBiology: “Pre-cut” sutures in various temporary protective structures, shells, covers, which must be easily opened (e.g. nuts, pods, and cocoons).\r\n",principle_number:'10' },
        { title: 'Beforehand cushioning', description: "Prepare emergency means beforehand to compensate the relatively low reliability of an object (“belt and braces”) \r\n\r\nTechnology: Bubble-wrap, sand-pit for sport jumpers, soft seats in any transport, air bags in the car, knee-pads for builders.\r\nBiology: Soft inlays of any nests (birds, rodents, bumblebees) to protect offspring (eggs and brood) from elements and shocks.\r\n",principle_number:'11' },
        { title: 'Equipotentiality', description: "If an object has to be raised or lowered, redesign the objects environment so the need to raise or lower is eliminated or performed by environment\r\n\r\nTechnology: Scaffolding, wheel-chair-friendly environment, stilts, position height of door handles, tables, desks, spy-holes in the entrance doors.\r\nBiology: Ungulate herbivorous animals (goats, antelopes, etc)  while grazing on high mountain slopes always prefer to move at the same level  leaving the horizontal paths behind.\r\n",principle_number:'12' },
        { title: 'The other way round', description: "•	Invert the action used to solve the problem\r\n•	Make movable parts (or external environment)  fixed, and fixed parts movable\r\n•	Turn the object (or process) upside down\r\n\r\nTechnology: Circular saws and planers can be table mounted and hand-held\r\nBiology: Birds perch of ON a tree branchand but bats hang UNDER a tree branch. Extra-corporal digestion in spiders  is the other way round comparing to incorporate digestion id the most of  animals. \r\nEscaping strategies of prey from a predator: fast run or total immobility to hide – two opposite styles.\r\n",principle_number:'13' },
        { title: 'Spheroidality and Curvature', description: "•	Move from flat surfaces to spherical ones and from parts shaped as a cube (parallelepiped) to ball-shaped structures\r\n•	Use rollers, balls, spirals \r\n•	Go from linear to rotary motion (or vice versa)\r\n•	Use centrifugal forces\r\n\r\nTechnology: A wheel, a ball-bearing, round-about, a turbine, a threaded bolt and nut.\r\nBiology: Most of morphological structures in living systems have circular, toroid, spherical, cylindrical, conical, discoid, spiral and/or helical shapes: eggs, eye-ball, blood-vessels, many fruits, stems of plants, shape of bacterial colonies, macrostructure of DNA.\r\n",principle_number:'14' },
        { title: 'Dynamics', description: "•	Change the object (or outside environment) for optimal performance at every stage of operation – make them adaptable\r\n•	Divide an object into parts capable of movement relative to each other\r\n•	Change from immobile to mobile.\r\n•	Increase the degree of free motion\r\n\r\nTechnology: Folding furniture (chairs, tables, beds), knife, ruler. \r\nBiology: Foldable wings of the evolutionary-advanced insects (e.g., locusts and beetles) comparing with the ancient ones (e.g., dragon-flies, butterflies).\r\n",principle_number:'15' },
        { title: 'Partial or excessive action, Abundance', description: "•	If  you can’t achieve 100 per cent of a desired effect then go for \r\n•	more or less\r\n•	Sometimes the decreased quality solves your problem\r\n\r\nTechnology: An umbrella protects from the rain and steel helmet from the bullets only partly. “Belt-and-braces” is an alternative strategy:  excessive strength of water dykes, bridges, any other safety measures.\r\nBiology: Pain-killer cures only symptom – partial action. Excessive functions in living systems are more wide-spread than the partial: excessive number of seeds, spores, pollen, fish-eggs, spermatozoids.\r\n",principle_number:'16' },
        { title: 'Another dimension', description: "•	Move into an additional dimension – from 1D to 2D,  from 2D to 3D\r\n•	Go from single storey or layer to multi-layered\r\n•	Incline an object, lay it on its side\r\n•	Use the other side of the object\r\n\r\nTechnology: Multi-store parking, road-bridges, double-decker busses. Corrugated materials to provide rigidity of boxes, containers, roofing sheets, etc.\r\nBiology: Corrugated leaves of plants  and wings of insects provide extra rigidity. Eyes and nostrils of a crocodile are at the upper-most position, which allows to stay submerged (and thus being hidden), but to see everything above the water level and breath.\r\n",principle_number:'17' },
        { title: 'Mechanical vibration', description: "•	Cause an object to oscillate or vibrate\r\nIncrease its frequency (even up to the ultrasonic)\r\n•	Use an object resonant frequency\r\nUse piezoelectric vibrators instead of mechanical ones\r\n•	Use combined ultrasonic and electromagnetic field oscillations\r\n\r\nTechnology: Impact power drill is more effective than the conventional one based only on rotation motion; \r\ncompacting concrete or rammed-earth construction with vibrator. \r\nBiology: All acoustic signalization among animals including ultra- and infra-sound. Echo-location of bats and dolphins. High-frequency pecking by wood-pecker.\r\n",principle_number:'18' },
        { title: 'Periodic action', description: "•	Instead of continuous action, use periodic or pulsating actions\r\n•	If an action is already periodic, change the periodic magnitude or frequency\r\n•	Use pauses between actions to perform a different action \r\n\r\nTechnology: Hand-saw, piston-and-cylinder system (a pump and an engine), sewing machine, pendulum of a mechanical clock, a machine-gun.\r\nBiology: Periodic activity is widely spreadin life: seasonal and diurnal activity cycles of sleeping and staying awake,  reproducing cycles, heart-beats, respiratory motions. Reciprocative motion is one of the basic mechanisms of locomotion in animals with limbs - legs, flippers, wings.\r\n",principle_number:'19' },
        { title: 'Continuity of useful action', description: "Carry on work without a break. All parts of an object operating constantly at full capacity.\r\n\r\nTechnology: Machinery based on rotation - continuous motion: circular saw, centrifugal pump, escalator, conveyer belt.\r\nBiology: Blood and air circulation process, metabolism as a continuous process and life itself as a phenomenon on our planet.\r\n",principle_number:'20' },
        { title: 'Skipping/Rushing through', description: "Conduct a process or certain stages of it (e.g. destructible, harmful, hazardous operations) at high speed\r\n\r\nTechnology: Cinematograph - 24 frames persecond give impression of continuous motion of an image on the screen; a mousetrap.\r\nBiology: Blinking of an eye, jumping, skipping, leaping  are wide-spread modes of animals’ locomotion. Main strategy of ambush: predators are rushing at maximum speed to catch its prey.\r\n",principle_number:'21' },
        { title: 'Blessing in disguise - turn harm into benefit', description: "•	Use harmful factors (from environment as well) to achieve a positive effect\r\n•	Eliminate the primary harmful action by adding it to another harmful action to resolve the problem\r\n•	Amplify a harmful factor to such a degree that it is no longer harmful\r\n\r\nTechnology: The finest cement dust, which escapes from the filters, is the highest quality cement. Snow due to its porosity provides insulation in spite of its own low temperature (the Inuits’ dwelling - igloo).\r\nBiology: Recycling is very common in the ecosystem. Dung as a waste turns into valuable fertilizer on a field. Mould appeared precious raw material for making penicillin.\r\n",principle_number:'22' },
        { title: 'Feedback', description: "•	Introduce feedback to improve the process of action\r\n•	If feedback is already used, change its magnitude or influence in accordance with operating conditions\r\n•	Change negative feedback to positive one or vice versa\r\n\r\nTechnology: NEGATIVE FEEDBACK - toilet cistern that has self-regulating level of water after waste flashing, thermo-regulator in a refrigerator keeps stable temperature within the given range. \r\n\r\nPOSITIVE FEEDBACK  self-tightening rope loop: the more it is loaded - the tighter the loop.\r\n\r\nBiology: NEGATIVE FEEDBACK - any physiological mechanisms and reactions of a living system to maintain the dynamic equilibrium of the internal parameters (body temperature, blood pressure, mineral composition of a body, etc). Ecological equilibrium in an ecosystem is maintained by various sub-systems like “predator - prey”, “host - parasite”, “plant - herbivorous animal”.\r\n\r\nPOSITIVE FEEDBACK - epidemic spread of any infection. A courtship for establishment of a male-female couple.\r\nFEED FORWARD -  analysis and decision making is impossible without extrapolation and prediction of events. Feed forward is very common in life and is the main mechanism of adaptation: being proactive rather than reactive.\r\n",principle_number:'23' },
        { title: 'Intermediary/Mediator', description: "•	Use an intermediary carrier article or intermediary process\r\n•	Merge one object temporary with another (which can be easily removed)\r\n\r\nTechnology: Any lubricant, water in the central-heating system of a building, a packaging.\r\nBiology: Insects-pollinators (e.g., bumblebees) of crops (e.g., raspberries, straw-berries, peppers, cucumbers, egg-plants, clover), blood as a medium for transportation of nutrients, oxygen, hormones and withdrawal of wastes of metabolism and CO2\r\n",principle_number:'24' },
        { title: 'Self-Service', description: "•	An object must service itself by performing auxiliary helpful function\r\n•	Use waste resources\r\nTechnology: Semi-spherical cupolas clean themselves from snow in winter due to wind. Self-service in the shops, restaurants, launderettes, self-sealing tyres of cars\r\nBiology: Self-sealing of blood-vessels due to coagulation of blood, self-cleaning surfaces of Indian Lotus and Nepenthes, self-sharpening teeth of rodents.\r\n",principle_number:'25' },
        { title: 'Copying, operating with substitute', description: "•	Replace unavailable, expensive, fragile or bulky object with convenient copies\r\n•	Replace an object, or process with optical copies\r\n•	If visible optical copies are used, move to infrared or ultraviolet copies\r\nTechnology: Modelling: computer simulation, dummies, card-board architectural models. Juridical field: most of documents - passports, ID, power of attorney. Money: golden coins, banknotes, cheque, plastic cards. Art: photo-, video-, filming-, video-copying,  copies of pictures and sculptures (legal and illegal). Illegal copying means piracy.\r\nBiology: Cloning/self-replicating, mimicry, camouflage and deception, copying of behaviour - one of the types of learning.\r\n",principle_number:'26' },
        { title: 'Cheap short-living objects', description: "Replace an expensive object with a multiple of inexpensive objects, compromising certain qualities, such as service life.\r\n\r\nTechnology; Hygienic disposable items: toilet tissue, diapers, handkerchieves, rubber gloves. Disposable catering items: plastic spoons, forks, knives, plates, cups. Medical instruments: syringes, scalpels, etc. Matches. Most of packaging items and materials. Postcards. \r\n\r\nBiology: Leaves of a tree, pollen, spores, spermatozoids, fruits and seeds, shells of eggs, nuts, seeds, cocoons, feathers, hair, fur, finger-nails, claws and other structures based on epithelium of skin. \r\n",principle_number:'27' },
        { title: 'Mechanics substitution', description: "Replace a mechanical system with a field one \r\n\r\nTechnology: A letter  sent by post --> telephone, telegraph, radio, fax, e-mail. Physical contact --> optical, chemical, electro-magnetic, acoustic location and communication. \r\nBiology: Chemical, acoustical, optical repellents and attractants.\r\n",principle_number:'28' },
        { title: 'Pneumatics and hydraulics', description: "Use gas and/or liquid parts of an object instead of solid parts (e.g., inflatable,  filled with liquid, air cushion, hydraulic, hydro-reactive, pneumatic)\r\n\r\nTechnology: Pneumatic tyres, hydraulic brakes, medical syringe.\r\nBiology: Sneezing, coughing and spitting are based on pneumatics. Growth of plants’ roots is based on hydraulics and can break tarmac roads and concrete walls.\r\n",principle_number:'29' },
        { title: 'Flexible shells and thin films', description: "•	Use flexible shells and thin films instead of 3D structures\r\n•	Isolate the object from external environment using flexible membranes \r\n\r\nTechnology: Plastic bags and bottles, plastic films instead of glass in green-houses,  tents, parachute, sails, fabric and clothes, paper, thin metal foil,  layers of plywood.\r\nBiology: Plant leaves, blood vessels, lungs, intestines, skin, cell membrane, living film on water surface - pleiston.  Webbing of bats’ wings, duck’s and frog’s feet, wings of insects.\r\n",principle_number:'30' },
        { title: 'Porous materials', description: "•	Make an object  porous or add porous elements\r\n•	If an object is already porous, use pores to introduce a useful substance or function \r\n\r\nTechnology: Foams as a mean of fire-extinguishing, detergents. Various froths in food industry. Bread. Filters.\r\nBiology: Timber as anisotropic porous material; living sponges, porous structure of bones; endoskeleton of cuttlefish.\r\n",principle_number:'31' },
        { title: 'Colour change', description: "•	Change the colour of an object or its external environment\r\n•	Change the transparency of an object or its external environment\r\n•	In order to improve visibility of things that are difficult to see, use colour additives or luminescent elements\r\n•	Change the emissive properties of an object subject to radiant heating.  \r\n\r\nTechnology: High-visibility and camouflage jackets. Photosensitive glass. Traffic lights. “Invisible ink” that can be detected in ultra-violet rays. Light colours are employed for sun-rays reflection and dark/black ones - for absorbing them as well, as for better dissipation of heat.\r\n\r\nBiology: Warning colours of poisonous animals; visual/optical camouflage; diversity and contrast colours of blooming flowers as the signal for insect-pollinators; changing of colours with the help of micro-relief of the surface: feathers of birds and wings of butterflies.\r\n",principle_number:'32' },
        { title: 'Homogeneity', description: "Objects interacting with the main object should be of same material (or material with identical properties).\r\n\r\nTechnology: Water and ice-cubes to chill the drink in the glass, rammed earth/clay building technology, thatched roofs, igloo.\r\nBiology: Jelly-fish consists on 98% of water – the environment where it lives. Termites’ mounds are re-arranged and fortified surrounding ground. Camouflage is based on homogeneity of the object with its environments.\r\n",principle_number:'33' },
        { title: 'Rejecting, discarding-recovering, regenerating', description: "•	After completing their function (or becoming useless), reject objects, make them go away, (discard  them by dissolving, evaporating, etc.) or modify them during the process\r\n•	Restore consumable/used up parts of an object during operation.\r\n\r\nTechnology: Disposable batteries,  a utility-knife with the sliding out blade with breaking-off sections, magazine of a machine-gun.\r\nBiology: A lizard shedding its tail; regeneration of outer layer of skin and hair, nails, claws, feathers; regeneration of twigs of a tree after trimming and grass after mowing.\r\n",principle_number:'34' },
        { title: 'Parameters change', description: "•	Change the physical state (e.g.,  to gas, liquid, or solid)\r\n•	Change a concentration or density\r\n•	Change the degree of flexibility\r\n•	Change the temperature or volume\r\n•	Change the pressure\r\n•	Change any parameter\r\n\r\nTechnology: Parameter of size: push pin, bradawl - garden dibber; roller-ball pen - roll-on deodorant bottle.\r\nBiology: The same species but bread in different conditions have sufficient morphological difference (a tree in a dense forest and the same species of tree on the open space).\r\n",principle_number:'35' },
        { title: 'Phase transition', description: "Use phenomena of phase transition (e.g., volume change, loss or absorption of heat, etc.)\r\n\r\nTechnology: All refrigerating devices - fridges, freezers, air-conditioners, dehumidifiers. The frozen water-bodies (rivers, ponds, lakes) can be used as winter roads and bridges.\r\n\r\nBiology: Transpiration in plants, evaporation of various pheromones and other volatile substances in plants and animals, gases (O2 and CO2) in lungs in the course of respiration.\r\n",principle_number:'36' },
        { title: 'Thermal Expansion', description: "•	Use thermal expansion or contraction of material\r\n•	Use multiple materials with different coefficient of thermal expansion\r\n\r\nTechnology: Bi-metal thermometers. Expansion space in rail joint and large metal bridges.  \r\nBiology: In biological systems this principle is practically absent. Cracks of rocks due to seasonal differences of temperatures are “employed” by plants’ roots to penetrate in and enlarge them by growing and anchoring in.\r\n",principle_number:'37' },
        { title: 'Strong oxidants', description: "•	Replace common air with oxygen-enriched air\r\n•	Replace common air with pure oxygen\r\n•	Expose air or oxygen to ionising radiation\r\n•	Use ionised oxygen\r\n•	Replace ozonised (or ionised) oxygen with ozone\r\n\r\nTechnology: Most of disinfectants (e.g., iodine, ozone). \r\nBiology: Use of acids by various organisms as venoms (ants) or irritants (nettle). \r\n",principle_number:'38' },
        { title: 'Inert atmosphere or vacuum', description: "•	Replace a normal environment with an inert one\r\n•	Add neutral parts, or inert additives to an object\r\n\r\nTechnology; Incandescent bulb. Fire extinguishing with the help of inert gases. Vacuum and \r\ninert-atmosphere packaging. Plunger for unblocking waste pipes\r\nBiology: Various suckers for attaching (octopus, squid, shark-sucker fish, helminthes).\r\n",principle_number:'39' },
        { title: 'Composites', description: "Change from uniform to non-uniform composition. \r\n\r\nTechnology: Chip-board, ply-wood, fiberboard, concrete, carbon-fibre and fiber-glass composites.\r\nBiology: Three-layer shells of mollusks, bones of vertebrate animals, exoskeleton of insects, wood/timber and skin/leather.\r\n",principle_number:'40' }
    ]

    populate Principle, principles

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

    entity_functions =[
        {title: 'Create', description: "", children: [
            {title: 'Produce', description: "", children: [
                {title: 'Form', description: "", children: []},
                {title: 'Fabricate', description: "", children: []},
                {title: 'Compose', description: "", children: []},
                {title: 'Secrete', description: "", children: []},
                {title: 'Generate', description: "", children: []},
                {title: 'Excrete', description: "", children: []},
                {title: 'Emit', description: "", children: []} ]},
            {title: 'Reproduce', description: "", children: [
                {title: 'Multiply', description: "", children: []},
                {title: 'Repeat', description: "", children: []},
                {title: 'Breed', description: "", children: []},
                {title: 'Regenerate', description: "", children: []} ]},
            {title: 'Grow', description: "", children: [
                {title: 'Accumulate', description: "", children: []},
                {title: 'Bulk', description: "", children: []},
                {title: 'Develop', description: "", children: []},
                {title: 'Expand', description: "", children: []},
                {title: 'Emerge', description: "", children: []},
                {title: 'Ripen/mature', description: "", children: []},
                {title: 'Sprout', description: "", children: []} ]},
            {title: 'Sediment', description: "", children: [
                {title: 'Collect/gather', description: "", children: []},
                {title: 'Store', description: "", children: []},
                {title: 'Pack', description: "", children: []},
                {title: 'Install', description: "", children: []},
                {title: 'Put/lay', description: "", children: []},
                {title: 'Save/reserve', description: "", children: []} ]},
            {title: 'Make', description: "", children: [
                {title: 'Use natural object', description: "", children: []},
                {title: 'Modify natural object', description: "", children: []},
                {title: 'Design', description: "", children: []},
                {title: 'Invent/insight', description: "", children: []},
                {title: 'Build', description: "", children: []} ]},
        ]},
        {title: 'Preserve', description: "", children:[
            {title: 'Protect', description: "", children: [
                {title: 'Clean', description: "", children: []},
                {title: 'Seal', description: "", children: []},
                {title: 'Camouflage', description: "", children: []},
                {title: 'Repell', description: "", children: []},
                {title: 'Block', description: "", children: []},
                {title: 'Hide', description: "", children: []},
                {title: 'Take care', description: "", children: []},
                {title: 'Cover', description: "", children: []},
                {title: 'Shield', description: "", children: []},
                {title: 'Resist', description: "", children: []},
                {title: 'Guard', description: "", children: []},
                {title: 'Watch/look out', description: "", children: []},
                {title: 'Escort', description: "", children: []},
                {title: 'Patrol', description: "", children: []} ]},
            {title: 'Defend', description: "", children: [
                {title: 'Stop', description: "", children: []},
                {title: 'Beat', description: "", children: []},
                {title: 'Escape', description: "", children: []},
                {title: 'Attack', description: "", children: []},
                {title: 'Fight', description: "", children: []},
                {title: 'Dominate/suppress', description: "", children: []} ]},
            {title: 'Feed', description: "", children: [
                {title: 'Nourish', description: "", children: []},
                {title: 'Deposit', description: "", children: []},
                {title: 'Exchange', description: "", children: []},
                {title: 'Deliver', description: "", children: []},
                {title: 'Embed', description: "", children: []},
                {title: 'Absorb', description: "", children: []},
                {title: 'Reserve', description: "", children: []} ]},
            {title: 'Support', description: "", children: [
                {title: 'Hold', description: "", children: []},
                {title: 'Border', description: "", children: []},
                {title: 'Keep shape', description: "", children: []},
                {title: 'Bear load', description: "", children: []},
                {title: 'Carry', description: "", children: []},
                {title: 'Uphold', description: "", children: []},
                {title: 'Maintain', description: "", children: []},
                {title: 'Stabilise', description: "", children: []} ]},
        ]},
        {title: 'Convert', description: "", children: [
            {title: 'Change phase', description: "", children: [
                {title: 'Melt', description: "", children: []},
                {title: 'Feeeze', description: "", children: []},
                {title: 'Evaporate', description: "", children: []},
                {title: 'Crystallize', description: "", children: []},
                {title: 'Precipitate', description: "", children: []},
                {title: 'Sublimate', description: "", children: []},
                {title: 'Solidify', description: "", children: []},
                {title: 'Condense', description: "", children: []},
                {title: 'Clot', description: "Congeal", children: []} ]},
            {title: 'Transform', description: "", children: [
                {title: 'Inclde', description: "", children: []},
                {title: 'Exclude', description: "", children: []},
                {title: 'Change', description: "Metamorphose", children: []},
                {title: 'Ram', description: "", children: []},
                {title: 'Coagulate', description: "", children: []},
                {title: 'Mutate', description: "", children: []},
                {title: 'Invert', description: "", children: []},
                {title: 'Re-combine', description: "", children: []},
                {title: 'Reform', description: "", children: []},
                {title: 'Re-organise', description: "", children: []},
                {title: 'Substitute', description: "", children: []},
                {title: 'Thicken', description: "", children: []},
                {title: 'Deoxidise', description: "", children: []},
                {title: 'Assimilate', description: "", children: []},
                {title: 'Curdle', description: "Anabiosis", children: []},
                {title: 'Purify', description: "", children: []},
                {title: 'Conform', description: "", children: []},
                {title: 'Petrify', description: "", children: []} ]},
        ]},
        {title: 'Move', description: "", children: [
            {title: 'Transport', description: "", children: [
                {title: 'Expulsive reflex', description: "", children: []},
                {title: 'Relocate', description: "", children:[
                    {title: 'Shift', description: "", children: []},
                    {title: 'Transplant', description: "", children: []} ]},
                {title: 'Distribute', description: "", children: []},
                {title: 'Migrate', description: "", children: []},
                {title: 'Convey', description: "", children: []},
                {title: 'Penetrate', description: "", children: []},
                {title: 'Import', description: "", children: []},
                {title: 'Pass', description: "", children: []},
                {title: 'Transfer', description: "", children: []},
                {title: 'Consign', description: "", children: []},
                {title: 'Infuse', description: "", children: []},
                {title: 'Interchange', description: "", children: [
                    {title: 'Dry', description: "", children: []},
                    {title: 'Ventilate', description: "", children: []} ]},
                {title: 'Transmit', description: "", children: []} ]},
            {title: 'Locomote', description: "", children: [
                {title: 'Orient', description: "", children: []},
                {title: 'Fly', description: "", children: [
                    {title: 'Glide', description: "", children: []}]},
                {title: 'Roll', description: "", children: []},
                {title: 'Traverse', description: "", children: []},
                {title: 'Swivel', description: "", children: []},
                {title: 'Vibrate', description: "", children: []},
                {title: 'Crawl', description: "", children: []},
                {title: 'Walk', description: "", children: []},
                {title: 'Jump', description: "", children: []},
                {title: 'Run', description: "", children: []},
                {title: 'Climb', description: "", children: []},
                {title: 'Burrow', description: "", children: []},
                {title: 'Screw', description: "", children: []},
                {title: 'Turn', description: "", children: []},
                {title: 'Jet', description: "", children: []},
                {title: 'Ride', description: "", children: []},
                {title: 'Ramble', description: "", children: []},
                {title: 'Prowl', description: "", children: []},
                {title: 'Swim', description: "", children: [
                    {title: 'Flow', description: "", children: []},
                    {title: 'Float', description: "", children: []},
                    {title: 'Drift', description: "", children: []}]} ]},
            {title: 'Manipulate', description: "", children: [
                {title: 'Lift', description: "", children: []},
                {title: 'Drop', description: "", children: []},
                {title: 'Push', description: "", children: []},
                {title: 'Pull', description: "", children: []},
                {title: 'Twist', description: "", children: []},
                {title: 'Flatten', description: "", children: []},
                {title: 'Spread', description: "", children: []},
                {title: 'Construct', description: "", children: []},
                {title: 'Shake', description: "", children: []}]},
            {title: 'Group', description: "", children: []},
            {title: 'Ungroup', description: "", children: []},
            {title: 'Intake', description: "", children: []},
            {title: 'Assemble', description: "", children: [
                {title: 'Merge', description: "", children: []},
                {title: 'Fasten', description: "", children: []},
                {title: 'Attach', description: "", children: []},
                {title: 'Glue', description: "", children: []}]}
        ]},
        {title: 'Regulate', description: "", children: [
            {title: 'Inform', description: "", children: [
                {title: 'Measure', description: "", children: []},
                {title: 'Communicate', description: "", children: []},
                {title: 'Deception', description: "Lie", children: []},
                {title: 'Attract', description: "", children: []},
                {title: 'Learn', description: "", children: []},
                {title: 'Teach', description: "", children: []},
                {title: 'Mark', description: "Rank, lable", children: []},
                {title: 'Record', description: "", children: []},
                {title: 'Translate', description: "", children: []},
                {title: 'Report', description: "", children: []},
                {title: 'Specify', description: "", children: []},
                {title: 'Reveal', description: "", children: []},
                {title: 'Impress', description: "", children: []},
                {title: 'Describe', description: "", children: []},
                {title: 'Sense', description: "", children: []},
                {title: 'Detect', description: "", children: []},
                {title: 'Signal', description: "", children: []}]},
            {title: 'React', description: "", children: [
                {title: 'Select', description: "", children: []},
                {title: 'Response', description: "", children: []},
                {title: 'Reflux', description: "", children: []},
                {title: 'Reflex', description: "", children: []},
                {title: 'Compensate', description: "", children: []},
                {title: 'Trigger', description: "", children: []},
                {title: 'Reinstate', description: "", children: []}]},
            {title: 'Manage', description: "", children: [
                {title: 'Control', description: "", children: []},
                {title: 'Delegate', description: "", children: []},
                {title: 'Help', description: "", children: []},
                {title: 'Suppress', description: "", children: []},
                {title: 'Govern', description: "", children: []},
                {title: 'Guide', description: "", children: []},
                {title: 'Check', description: "", children: []},
                {title: 'Restrain', description: "", children: []},
                {title: 'Counteract', description: "", children: []} ]},
            {title: 'Regulate temperature', description: "", children: [
                {title: 'Heat', description: "", children: []},
                {title: 'Cool', description: "", children: []},
                {title: 'Freeze', description: "", children: []},
                {title: 'Adjust', description: "", children: []},
                {title: 'Insulate', description: "", children: []},
                {title: 'Grade', description: "", children: []}]},
            {title: 'Regulate light', description: "", children: [
                {title: 'Insolate', description: "", children: []},
                {title: 'Ignite', description: "", children: []},
                {title: 'Blase', description: "", children: []},
                {title: 'Glow', description: "", children: []},
                {title: 'Illuminate', description: "", children: []} ]}
        ]},
        {title: 'Destroy', description: "", children: [
            {title: 'Capture', description: "", children: [
                {title: 'Graze', description: "", children: []},
                {title: 'Ingest', description: "", children: []},
                {title: 'Suck', description: "", children: []},
                {title: 'Lick off', description: "", children: []},
                {title: 'Bite', description: "", children: []},
                {title: 'Snap', description: "", children: []},
                {title: 'Eat', description: "", children: []},
                {title: 'Dissolve', description: "", children: []}]},
            {title: 'Destruct', description: "", children: [
                {title: 'Self-destruct', description: "", children: []},
                {title: 'Invade', description: "", children: []},
                {title: 'Decrease', description: "", children: []},
                {title: 'Bend', description: "", children: []},
                {title: 'Gnaw', description: "", children: []},
                {title: 'Munch', description: "", children: []},
                {title: 'Digest', description: "", children: []},
                {title: 'Chew', description: "", children: []},
                {title: 'Shred', description: "", children: []},
                {title: 'Chop', description: "", children: []},
                {title: 'Cut', description: "", children: []},
                {title: 'Break', description: "", children: []},
                {title: 'Decompose', description: "", children: []},
                {title: 'Eliminate', description: "", children: []},
                {title: 'Remove', description: "", children: []},
                {title: 'Cease', description: "", children: []},
                {title: 'Discontinue', description: "", children: [
                    {title: 'Switch off', description: "", children: []},
                    {title: 'Disrupt', description: "", children: []}]},
                {title: 'Crack', description: "", children: []},
                {title: 'Compress', description: "", children: []},
                {title: 'Squeeze', description: "", children: []},
                {title: 'Deactivate', description: "", children: []},
                {title: 'Dissect', description: "", children: []},
                {title: 'Split', description: "", children: []},
                {title: 'Crash', description: "", children: []},
                {title: 'Crumble', description: "", children: []},
                {title: 'Burst', description: "", children: []},
                {title: 'Scatter', description: "", children: []},
                {title: 'Annihilate', description: "", children: []}]},
        {title: 'Wear/sweep away', description: "", children: [
            {title: 'Erode', description: "", children: []},
            {title: 'Corrode', description: "", children: []} ]},
        {title: 'Kill', description: "", children: [
            {title: 'Poison', description: "", children: []},
            {title: 'Paralyse', description: "", children: []},
            {title: 'Infect', description: "", children: []},
            {title: 'Suffocate', description: "", children: []}]}
        ]} ]




  end
end
