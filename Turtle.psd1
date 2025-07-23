@{
# Script module or binary module file associated with this manifest.
RootModule = 'Turtle.psm1'
# Version number of this module.
ModuleVersion = '0.1'
# ID used to uniquely identify this module
GUID = '80a19066-8558-4a56-a279-88464ef47ac8'
# Author of this module
Author = 'JamesBrundage'
# Company or vendor of this module
CompanyName = 'Start-Automating'
# Copyright statement for this module
Copyright = '2025 Start-Automating'
# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @('Turtle.types.ps1xml')
# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()
# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = '*'
# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'
# Variables to export from this module
VariablesToExport = '*'
# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'
# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{
    PSData = @{
        # Tags applied to this module. These help with module discovery in online galleries.
        Tags       = 'PowerShell', 'Turtle', 'SVG', 'Graphics', 'Drawing', 'L-System', 'Fractal'
        # A URL to the main website for this project.
        ProjectURI = 'https://github.com/PowerShellWeb/Turtle'
        # A URL to the license for this module.
        LicenseURI = 'https://github.com/PowerShellWeb/Turtle/blob/main/LICENSE'        
    }
}

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

