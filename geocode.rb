require 'net/http'
require 'uri'
require 'json'
require 'erb'

def fetch_coordinates(address)
  uri = URI.parse("https://nominatim.openstreetmap.org/search?q=#{ERB::Util.url_encode(address)}&format=json&limit=1")
  request = Net::HTTP::Get.new(uri)
  request['User-Agent'] = 'MyApp (your-email@example.com)'  # Replace with your custom user agent and email

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  result = JSON.parse(response.body).first
  if result
    { latitude: result['lat'].to_f, longitude: result['lon'].to_f }
  else
    { latitude: nil, longitude: nil }
  end
rescue JSON::ParserError => e
  puts "Error parsing JSON for address: #{address}"
  { latitude: nil, longitude: nil }
end

# Array of restaurant addresses
restaurants = [
  { name: '1308 Chicago', address: '1308 N Milwaukee Ave, Chicago, IL 60622' },
  { name: 'Aba', address: '302 N Green St, Chicago, IL 60607' },
  { name: 'Arabella', address: '108 W Huron St, Chicago, IL 60654' },
  { name: 'Avec', address: '615 W Randolph St, Chicago, IL 60661' },
  { name: 'Bambola', address: '1508 W Jarvis Ave, Chicago, IL 60626' },
  { name: 'Bandit', address: '841 W Randolph St, Chicago, IL 60607' },
  { name: 'Bandol', address: '142 W Monroe St, Chicago, IL 60603' },
  { name: 'Bar Goa', address: '2471 N Lincoln Ave, Chicago, IL 60614' },
  { name: 'Bar Sotto', address: '337 N Sangamon St, Chicago, IL 60607' },
  { name: 'Beatrix', address: '671 N St Clair St, Chicago, IL 60611' },
  { name: 'Big Mini Putt Club', address: '3867 N Clark St, Chicago, IL 60613' },
  { name: 'Black Barrel', address: '1720 W Cortland St, Chicago, IL 60622' },
  { name: 'Bodega Taqueria', address: '1914 W North Ave, Chicago, IL 60622' },
  { name: 'Boqueria', address: '810 W Randolph St, Chicago, IL 60607' },
  { name: 'Brandon Speakeasy', address: '1424 W Chicago Ave, Chicago, IL 60642' },
  { name: 'Bub City', address: '435 N Clark St, Chicago, IL 60654' },
  { name: 'Buckets n Bubbles', address: '1170 W Madison St, Chicago, IL 60607' },
  { name: 'Café Ba Ba Reeba', address: '2024 N Halsted St, Chicago, IL 60614' },
  { name: 'Celeste', address: '111 W Hubbard St, Chicago, IL 60654' },
  { name: 'Chef\'s Special Socktail Bar', address: '959 W Belmont Ave, Chicago, IL 60657' },
  { name: 'City Social', address: '1004 N Rush St, Chicago, IL 60611' },
  { name: 'Coquette', address: '2049 W Division St, Chicago, IL 60622' },
  { name: 'Costera Cocina Tulum', address: '1800 N Lincoln Ave, Chicago, IL 60614' },
  { name: 'Deli Rooster', address: '1108 N State St, Chicago, IL 60610' },
  { name: 'Diego', address: '904 N Ashland Ave, Chicago, IL 60622' },
  { name: 'Dorothy', address: '2542 N Milwaukee Ave, Chicago, IL 60647' },
  { name: 'Ema', address: '74 W Illinois St, Chicago, IL 60654' },
  { name: 'Federales', address: '180 N Morgan St, Chicago, IL 60607' },
  { name: 'Forbidden Root', address: '1744 W 18th St, Chicago, IL 60608' },
  { name: 'Formento\'s', address: '925 W Randolph St, Chicago, IL 60607' },
  { name: 'Fulton Market Kitchen', address: '311 N Sangamon St, Chicago, IL 60607' },
  { name: 'Gaijin', address: '950 W Lake St, Chicago, IL 60607' },
  { name: 'Gemini', address: '2075 N Lincoln Ave, Chicago, IL 60614' },
  { name: 'Gilt Bar', address: '230 W Kinzie St, Chicago, IL 60654' },
  { name: 'GT Prime', address: '705 N Wells St, Chicago, IL 60654' },
  { name: 'Hampton Social', address: '353 W Hubbard St, Chicago, IL 60654' },
  { name: 'Hide + Seek', address: '1109 W Madison St, Chicago, IL 60607' },
  { name: 'IL Porcelino', address: '8 S Michigan Ave, Chicago, IL 60603' },
  { name: 'Ina Mae Tavern', address: '1415 N Wood St, Chicago, IL 60622' },
  { name: 'IO Godfrey', address: '127 W Huron St, Chicago, IL 60654' },
  { name: 'Jaleo', address: '555 N Clark St, Chicago, IL 60654' },
  { name: 'Joe\'s Seafood', address: '60 E Grand Ave, Chicago, IL 60611' },
  { name: 'Kincade\'s', address: '950 W Armitage Ave, Chicago, IL 60614' },
  { name: 'La Grande Boucherie', address: '1958 N Damen Ave, Chicago, IL 60647' },
  { name: 'La Josie', address: '740 W Randolph St, Chicago, IL 60661' },
  { name: 'Lil Ba Ba Reeba', address: '1471 N Milwaukee Ave, Chicago, IL 60622' },
  { name: 'Lost Reef', address: '2235 S Wentworth Ave, Chicago, IL 60616' },
  { name: 'Mama Delia', address: '1721 W Division St, Chicago, IL 60622' },
  { name: 'Marshall\'s Landing', address: '800 S Leavitt St, Chicago, IL 60612' },
  { name: 'Moe\'s', address: '3518 N Clark St, Chicago, IL 60657' },
  { name: 'Moneygun', address: '660 W Lake St, Chicago, IL 60661' },
  { name: 'Monteverde', address: '1020 W Madison St, Chicago, IL 60607' },
  { name: 'Nisos Prime', address: '1201 W Grand Ave, Chicago, IL 60642' },
  { name: 'Nonnia', address: '340 N Clark St, Chicago, IL 60654' },
  { name: 'Olio', address: '904 N Ashland Ave, Chicago, IL 60622' },
  { name: 'Osteria Via Stato', address: '620 N State St, Chicago, IL 60654' },
  { name: 'PB&J', address: '1408 N Milwaukee Ave, Chicago, IL 60622' },
  { name: 'Porkchop BBQ', address: '1516 E Harper Ct, Chicago, IL 60615' },
  { name: 'Porter Kitchen and Deck', address: '150 N Riverside Plaza, Chicago, IL 60606' },
  { name: 'Proxi', address: '565 W Randolph St, Chicago, IL 60661' },
  { name: 'Punch Bowl Social', address: '310 N Green St, Chicago, IL 60607' },
  { name: 'Ramero', address: '1700 W Irving Park Rd, Chicago, IL 60613' },
  { name: 'Ranalli\'s', address: '1925 N Lincoln Ave, Chicago, IL 60614' },
  { name: 'River Roast', address: '315 N LaSalle Dr, Chicago, IL 60654' },
  { name: 'Robert\'s Pizza & Dough', address: '465 N McClurg Ct, Chicago, IL 60611' },
  { name: 'RPM Stakehouse', address: '317 N Marshfield Ave, Chicago, IL 60622' },
  { name: 'Siena Tavern', address: '51 W Kinzie St, Chicago, IL 60654' },
  { name: 'Smoke Daddy BBQ', address: '1804 W Division St, Chicago, IL 60622' },
  { name: 'Split Milk', address: '1032 W Fulton Market, Chicago, IL 60607' },
  { name: 'Stk', address: '9 W Kinzie St, Chicago, IL 60654' },
  { name: 'Storyville', address: '1937 W North Ave, Chicago, IL 60622' },
  { name: 'Sunda', address: '110 W Illinois St, Chicago, IL 60654' },
  { name: 'Sunnygun', address: '1608 N Western Ave, Chicago, IL 60647' },
  { name: 'Sushi San', address: '63 W Grand Ave, Chicago, IL 60654' },
  { name: 'Swift and Sons', address: '1000 W Fulton Market, Chicago, IL 60607' },
  { name: 'Tabu', address: '200 E 22nd St, Chicago, IL 60616' },
  { name: 'Tacombi', address: '305 N Richmond St, Chicago, IL 60647' },
  { name: 'Tallboy Taco', address: '325 W Huron St, Chicago, IL 60654' },
  { name: 'Tanta', address: '118 W Grand Ave, Chicago, IL 60654' },
  { name: 'Taste 222', address: '222 W Ontario St, Chicago, IL 60654' },
  { name: 'Texan Taco Bar', address: '1109 W Madison St, Chicago, IL 60607' },
  { name: 'The Drop in', address: '1909 N Lincoln Ave, Chicago, IL 60614' },
  { name: 'The Duplex', address: '2349 N Bell Ave, Chicago, IL 60647' },
  { name: 'The Loyalist', address: '177 N Ada St, Chicago, IL 60607' },
  { name: 'The Oakville', address: '1800 W 95th St, Chicago, IL 60643' },
  { name: 'The Press Room', address: '1134 W Washington Blvd, Chicago, IL 60607' },
  { name: 'The Robey', address: '2018 W North Ave, Chicago, IL 60647' },
  { name: 'The Smith', address: '400 N Clark St, Chicago, IL 60654' },
  { name: 'Timothy O\'Tooles', address: '622 N Fairbanks Ct, Chicago, IL 60611' },
  { name: 'Tree House', address: '149 W Kinzie St, Chicago, IL 60654' },
  { name: 'Trivoli Tavern', address: '1335 W Wrightwood Ave, Chicago, IL 60614' },
  { name: 'Untitled Supper Club', address: '111 W Kinzie St, Chicago, IL 60654' },
  { name: 'Upstairs at the Gwen', address: '521 N Rush St, Chicago, IL 60611' },
  { name: 'Valedor', address: '1141 N Ashland Ave, Chicago, IL 60622' },
  { name: 'Yours Truly', address: '619 N Fairbanks Ct, Chicago, IL 60611' },
  { name: 'Bocafitos', address: '1804 W Grand Ave, Chicago, IL 60622' },
  { name: 'King of Cups', address: '1532 N Milwaukee Ave, Chicago, IL 60622' },
  { name: 'Summer House Santa Monica', address: '1954 N Halsted St, Chicago, IL 60614' },
  { name: 'Happy Camper', address: '1209 N Wells St, Chicago, IL 60610' },
  { name: 'Amaru', address: '1028 N Clark St, Chicago, IL 60610' },
  { name: 'Revolver', address: '3759 N Damen Ave, Chicago, IL 60618' },
  { name: 'the Perch', address: '401 W Ontario St, Chicago, IL 60654' },
  { name: 'Bar Roma', address: '5101 N Clark St, Chicago, IL 60640' },
  { name: 'Lost Never Found', address: '', neighborhood: '', link: '' },
  { name: 'Beatnik', address: '', neighborhood: '', link: '' },
  { name: 'Dell Rooster', address: '', neighborhood: '', link: '' },
  { name: 'Elia', address: '', neighborhood: '', link: '' },
  { name: 'Machine: Engineered Drinks', address: '', neighborhood: '', link: '' },
  { name: 'The Dandy Crown', address: '', neighborhood: '', link: '' },
  { name: 'First Draft South Loop', address: '1420 S Michigan Ave, Chicago, IL 60605' },
  { name: 'Brando\'s Speakeasy', address: '', neighborhood: '', link: '' },
  { name: 'Catch 35', address: '', neighborhood: '', link: '' },
  { name: 'Maple and Ash', address: '', neighborhood: '', link: '' },
  { name: 'City Social', address: '1004 N Rush St, Chicago, IL 60611' }
]

# Fetch coordinates and print results
restaurants.each do |restaurant|
  coordinates = fetch_coordinates(restaurant[:address])
  puts "#{restaurant[:name]}: #{coordinates[:latitude]}, #{coordinates[:longitude]}"
  sleep(1)  # Add delay to respect the rate limit
end
