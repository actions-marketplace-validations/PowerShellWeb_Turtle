@{
    "runs-on" = "ubuntu-latest"    
    if = '${{ success() }}'
    steps = @(
        @{
            name = 'Check out repository'
            uses = 'actions/checkout@main'
        },                
        'RunEZOut' #  ,
        <#@{
            name = 'Run WebSocket (on branch)'
            if   = '${{github.ref_name != ''main''}}'
            uses = './'
            id = 'WebSocketAction'
        },#>
        # 'BuildAndPublishContainer'
    )
}