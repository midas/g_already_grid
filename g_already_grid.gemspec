# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{g_already_grid}
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["C. Jason Harrelson (midas)"]
  s.date = %q{2009-03-18}
  s.description = %q{A Guilded (http://github.com/midas/guilded/tree/master) Rails component that generates a rich grid control from an  ActiveRecord collection.}
  s.email = ["jason@lookforwardenterprises.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = [".git/COMMIT_EDITMSG", ".git/HEAD", ".git/config", ".git/description", ".git/hooks/applypatch-msg.sample", ".git/hooks/commit-msg.sample", ".git/hooks/post-commit.sample", ".git/hooks/post-receive.sample", ".git/hooks/post-update.sample", ".git/hooks/pre-applypatch.sample", ".git/hooks/pre-commit.sample", ".git/hooks/pre-rebase.sample", ".git/hooks/prepare-commit-msg.sample", ".git/hooks/update.sample", ".git/index", ".git/info/exclude", ".git/logs/HEAD", ".git/logs/refs/heads/master", ".git/logs/refs/remotes/origin/HEAD", ".git/logs/refs/remotes/origin/master", ".git/objects/02/85e65fe6d5a62b7badce283d02f1fb626a1ab7", ".git/objects/02/df3eba6f6e8eb54809d163a150c736f67c5a26", ".git/objects/07/823e3e4f3d9ec546d63b6559b37153c0df18a5", ".git/objects/0f/1236da897d1e58f4b07b708476a0501865b691", ".git/objects/0f/961dcada4c3a21a506f410718b1d01f36bd283", ".git/objects/12/6777195e9ef321021d14e942cd4160ce5eca1e", ".git/objects/19/4974f3fea3fc6a21372a4cef13599525714622", ".git/objects/22/4224da073354641355f3662e295d9ec99ef366", ".git/objects/28/bea3eb33169ff67ce34f82168d7cddc6caa440", ".git/objects/36/f59b31836194f47821bd21060c413f229cf174", ".git/objects/3b/2d1ce9b2f5e05f70403e08798b19cb962d84f4", ".git/objects/3c/79c1d2a5f3149296bd5a84a31f6c1e7df08400", ".git/objects/42/17c3829629b09f6757ee68353d7273920939fb", ".git/objects/43/4d1f35c9811567615eb0e13cd87f461a154e19", ".git/objects/45/b904d8ecd3149f3f16e9b86e917690e0eebef9", ".git/objects/4b/7f07757eb7e9560c7acfac98e2fa5b77da5a5e", ".git/objects/52/ede8cef7c02782dbfa6bc9b080384c58d553fd", ".git/objects/5a/2e88151df3b26c1283119bcd11f0e5c30d18e7", ".git/objects/5a/fb625dbee0c45379a4265db895899efab0cf97", ".git/objects/5b/44011696227f26a7c4d4c5b4b2874b9fe7bf7b", ".git/objects/5e/433b062a857c0497375c6fd621543106005ce8", ".git/objects/63/4f7d3f7733838417bc0fa090139ef05e15a74f", ".git/objects/69/2b527d6ddc2c88d57dd5fc6f36191ac7d7124c", ".git/objects/6c/41bedb7233e5cd29ef3f98982d6adabd0b58f9", ".git/objects/6f/d260879fc3d5afe7d68ef43d4466f2391760dd", ".git/objects/76/6f6a48a18be39f100b6bfe69a9a75c9d9f4690", ".git/objects/7d/4116571ec08a206a391f623ac73912707efaae", ".git/objects/7d/dd252e5bcb58a40d39450280d316c327354755", ".git/objects/7d/e4daf36d50aa32f6ce28e2d00237528fb5e87f", ".git/objects/89/886ddee8d0f5351dd33b70ecbadba7d443d40f", ".git/objects/90/b4678b2544afc9cd536bfb32dd5af301583752", ".git/objects/96/3a646fe4d05c3bcb0b9870bdcc6213422547d3", ".git/objects/97/5b7b15f1b0570bc2d65230ffb6a812cf3b27e1", ".git/objects/a1/89e4eb96aaef371bdd31f693034bcfd1c1475b", ".git/objects/a2/317f0f2f5513287c6b5297d1326ff7696b264f", ".git/objects/ab/f47258a219173a7071b0009ed1aa0b53070eec", ".git/objects/ac/42b393696e320f12b662f5dd9686a10655a9c5", ".git/objects/af/4892fceaaf4ae9e7ebe8fd83a321de6e0632ea", ".git/objects/b9/cf9d7dbe8121ede710d2c19a9f572988463a4d", ".git/objects/bb/1162c1f3474c8380d73f48d8af8567a6fe16b2", ".git/objects/c5/653762ee23dd313126ab500e3c827093e39fcf", ".git/objects/c8/1531972f4d15a3de66df8399ec48c8c5cdef68", ".git/objects/db/b6e045c18c46548458d88661efc638b6f33aca", ".git/objects/dd/c38c6eb601a6755bb6bd98ea4d04b7a035857a", ".git/objects/de/57e7ff9810fd6b3d199bda60880acf87f6c1bb", ".git/objects/de/6565d370577eee92734f8ed1907b46e9498d51", ".git/objects/de/e64a19bfaa35c06cd428fb4ad577332267f370", ".git/objects/e4/9df7e2a93d33bd572e458ac6422e93d2c75bb2", ".git/objects/e5/8db62de9ed9b73b92072850d37754de748e532", ".git/objects/e5/9a6a12400500cf1766d332a2735df85083edf8", ".git/objects/eb/82eeb8ee03b998e468aefd726752a4c2c2ab10", ".git/objects/ec/40c86e224f0744d32992dab3e4e8dfff4e44db", ".git/objects/f4/1a2149b85c693085022dceafbe5a0614f5b74a", ".git/objects/f7/9be5951a5f5229e87a2851944d127110e0f5b1", ".git/objects/fc/2f2fa2516ea0f3f1a58f525ff9054ad23e1d47", ".git/objects/fd/98e0f2c18555906861c26c1f0ee05580096caa", ".git/objects/fe/c84815790fe1587b2cdabdf0f62428e1808963", ".git/objects/ff/b6d7438661c2f47854344676bffd4b9b428b5e", ".git/objects/pack/pack-7aed4e203c2b94a917664d44a6cd37ca4eeecfea.idx", ".git/objects/pack/pack-7aed4e203c2b94a917664d44a6cd37ca4eeecfea.pack", ".git/packed-refs", ".git/refs/heads/master", ".git/refs/remotes/origin/HEAD", ".git/refs/remotes/origin/master", ".git/refs/tags/v1.0.0", ".git/refs/tags/v1.0.2", "History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "g_already_grid.gemspec", "lib/g_already_grid.rb", "lib/g_already_grid/templates/guilded.already_grid.html.erb", "lib/g_already_grid/view_helpers.rb", "rails_generators/already_grid_assets/already_grid_assets_generator.rb", "rails_generators/already_grid_assets/templates/default.css", "rails_generators/already_grid_assets/templates/gridHeadBg.gif", "rails_generators/already_grid_assets/templates/gridSort.gif", "rails_generators/already_grid_assets/templates/gridSortAsc.gif", "rails_generators/already_grid_assets/templates/gridSortDesc.gif", "rails_generators/already_grid_assets/templates/guilded.already_grid.js", "rails_generators/already_grid_assets/templates/guilded.already_grid.min.js", "rails_generators/already_grid_assets/templates/jquery-already_grid-0.1.js", "rails_generators/already_grid_assets/templates/jquery-already_grid-0.1.min.js", "script/console", "script/destroy", "script/generate", "spec/g_already_grid_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/midas/g_already_grid/tree/master}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{g_already_grid}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Guilded (http://github.com/midas/guilded/tree/master) Rails component that generates a rich grid control from an  ActiveRecord collection.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<rails>, [">= 2.2.0"])
      s.add_development_dependency(%q<midas-guilded>, [">= 0.1.4"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<rails>, [">= 2.2.0"])
      s.add_dependency(%q<midas-guilded>, [">= 0.1.4"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<rails>, [">= 2.2.0"])
    s.add_dependency(%q<midas-guilded>, [">= 0.1.4"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
