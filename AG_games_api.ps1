$search = 'fallen order'
$request =  'https://api.rawg.io/api/games?search=' + $search
$response = Invoke-WebRequest $request | ConvertFrom-Json  | select -expand results | select name, rating, metacritic, released, background_image
$response
# https://api.rawg.io/docs