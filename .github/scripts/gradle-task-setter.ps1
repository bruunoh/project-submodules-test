# Remove special chars from stringified json like [/\].
$changedModules = @($env:changed_modules -replace '[^a-zA-Z0-9,]', '' -split ',')
if( ($changedModules.count -eq 1) ) { # If only one module changed
  $changedModule = $changedModules[0]
  $taskPrefix = switch($changedModule) {
    'home' { 'home:' }
    default { '' }
  }
  echo "Only $changedModule module changed. I will run $taskPrefix$env:task gradle task :)"
  echo "::set-output name=gradleTask::$taskPrefix$env:task" # For example feature1:lintDebug
} else {
  echo "More than one module changed. These are the changed modules=$($changedModules -join ",")"
  echo "I will run $env:task gradle task for all modules :("
  echo "::set-output name=gradleTask::$env:task"
}