function initialize_abbrs
  abbr lf 'functions | tr ", " "\n" | fzf'
  abbr fl 'cd ~/Code'
  abbr dsh 'cd ~/Code/dashboard'
  abbr nv 'node --version'

  abbr g 'git'
  abbr gup 'git gup'

  abbr emp 'ember s --proxy https://api.flood.io'
  abbr eml 'ember s --proxy http://localhost:3000'
  abbr emm 'env MIRAGE=true ember s'

  abbr etu 'ember test --filter "Unit | "'
  abbr eti 'ember test --filter "Integration | "'
  abbr eta 'ember test --filter "Acceptance | "'

  abbr be 'bundle exec'
end
