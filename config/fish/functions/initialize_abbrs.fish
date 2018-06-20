function initialize_abbrs
  abbr lf 'functions | tr ", " "\n" | fzf'

  abbr nv 'node --version'

  abbr g 'git'
  abbr gup 'git gup'

  abbr emp 'ember s --proxy https://api.flood.io'
  abbr emm 'env MIRAGE=true ember s'

  abbr etu 'ember test --filter "Unit | "'
  abbr eti 'ember test --filter "Integration | "'
  abbr eta 'ember test --filter "Acceptance | "'
end
