cask 'goland' do
  version '2020.1.1,201.7223.36'
  sha256 '69a72a207a04e03c5adde97650da48ab61dd7b5efd61a322e19404f4a2a342d7'

  url "https://download.jetbrains.com/go/goland-#{version.before_comma}.dmg"
  appcast 'https://data.services.jetbrains.com/products/releases?code=GO&latest=true&type=release'
  name 'Goland'
  homepage 'https://www.jetbrains.com/go/'

  auto_updates true

  app 'GoLand.app'

  uninstall_postflight do
    ENV['PATH'].split(File::PATH_SEPARATOR).map { |path| File.join(path, 'goland') }.each { |path| File.delete(path) if File.exist?(path) && File.readlines(path).grep(%r{# see com.intellij.idea.SocketLock for the server side of this interface}).any? }
  end

  zap trash: [
               '~/Library/Application Support/GoLand',
               "~/Library/Application Support/GoLand#{version.major_minor}",
               "~/Library/Caches/GoLand#{version.major_minor}",
               "~/Library/Logs/GoLand#{version.major_minor}",
               "~/Library/Preferences/GoLand#{version.major_minor}",
               '~/Library/Preferences/com.jetbrains.goland.plist',
               '~/Library/Saved Application State/com.jetbrains.goland.SavedState',
             ]
end
