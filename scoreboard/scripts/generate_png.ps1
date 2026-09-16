Add-Type -AssemblyName System.Drawing

$size = 1024
$bmp = New-Object System.Drawing.Bitmap $size, $size
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# 1. Deep Luxurious Apple Red Gradient Background
$rect = New-Object System.Drawing.Rectangle 0, 0, $size, $size
$cTop = [System.Drawing.ColorTranslator]::FromHtml('#FF2E4D')
$cBottom = [System.Drawing.ColorTranslator]::FromHtml('#73000E')
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, $cTop, $cBottom, 45.0
$g.FillRectangle($bgBrush, $rect)

# 2. Ambient Studio Light Bloom (Top-center)
$bloomRect = New-Object System.Drawing.Rectangle 120, 40, 784, 680
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddEllipse($bloomRect)
$pBrush = New-Object System.Drawing.Drawing2D.PathGradientBrush $path
$pBrush.CenterColor = [System.Drawing.Color]::FromArgb(65, 255, 168, 180)
$pBrush.SurroundColors = @([System.Drawing.Color]::FromArgb(0, 230, 13, 40))
$g.FillEllipse($pBrush, $bloomRect)

# 3. Typography Setup for '3'
$format = New-Object System.Drawing.StringFormat
$format.Alignment = [System.Drawing.StringAlignment]::Center
$format.LineAlignment = [System.Drawing.StringAlignment]::Center

# Try system fonts with good bold weights
$fontFamilyName = "Arial Black"
$fontFamily = New-Object System.Drawing.FontFamily $fontFamilyName
$fontSize = 580

# 4. Deep Physical Drop & Caustic Shadows for the 3
$shadowRect1 = New-Object System.Drawing.RectangleF 0, 48, $size, $size
$shadowBrush1 = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(180, 45, 0, 6))
$gpShadow1 = New-Object System.Drawing.Drawing2D.GraphicsPath
$gpShadow1.AddString("3", $fontFamily, [int][System.Drawing.FontStyle]::Bold, $fontSize, $shadowRect1, $format)
$g.FillPath($shadowBrush1, $gpShadow1)

$shadowRect2 = New-Object System.Drawing.RectangleF 0, 24, $size, $size
$shadowBrush2 = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(120, 85, 0, 10))
$gpShadow2 = New-Object System.Drawing.Drawing2D.GraphicsPath
$gpShadow2.AddString("3", $fontFamily, [int][System.Drawing.FontStyle]::Bold, $fontSize, $shadowRect2, $format)
$g.FillPath($shadowBrush2, $gpShadow2)

# 5. Liquid Glass Body (Refractive Core)
$mainRect = New-Object System.Drawing.RectangleF 0, 8, $size, $size
$gp3 = New-Object System.Drawing.Drawing2D.GraphicsPath
$gp3.AddString("3", $fontFamily, [int][System.Drawing.FontStyle]::Bold, $fontSize, $mainRect, $format)

$glassBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, ([System.Drawing.Color]::FromArgb(250, 255, 255, 255)), ([System.Drawing.Color]::FromArgb(190, 255, 220, 228)), 60.0
$g.FillPath($glassBrush, $gp3)

# 6. Specular Prismatic Rim Highlight
$pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(230, 255, 255, 255)), 6
$g.DrawPath($pen, $gp3)

# 7. Save output PNG
$dest = "c:\Users\19681\Downloads\scoreboard\Scoreboard\Assets.xcassets\AppIcon.appiconset\AppIcon.png"
$bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()
Write-Host "AppIcon.png successfully created at $dest"
