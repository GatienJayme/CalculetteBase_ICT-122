#================================
#Name : Calculette.ps1
#Author : Christopher Pardo
#Date : 2020.05.14
#Version : 1.2
#Title : Calculatrice
#Description : 
#================================


#Graphic part ============================================================================================================================
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="Initial Window" WindowStartupLocation = "CenterScreen"
    Width = "800" Height = "600" ShowInTaskbar = "True">
        <Canvas x:Name="Canvas">
            <TextBox Name="TextBox" Height="75" Width="315" Canvas.Top="160" Canvas.Left="50" IsReadOnly="True"></TextBox>

            <Button x:Name = "Button0" Height = "75" Width = "155" Content = '0' ToolTip = "Button0"
            Canvas.Left = '50' Canvas.Top = '480' Tag = '0'/>
            <Button x:Name = "Button1" Height = "75" Width = "75" Content = '1' ToolTip = "Button1"
            Canvas.Left = '50' Canvas.Top = '400' Tag = '1'/>
            <Button x:Name = "Button2" Height = "75" Width = "75" Content = '2' ToolTip = "Button2"
            Canvas.Left = '130' Canvas.Top = '400' Tag = '2'/>
            <Button x:Name = "Button3" Height = "75" Width = "75" Content = '3' ToolTip = "Button3"
            Canvas.Left = '210' Canvas.Top = '400' Tag = '3'/>

            <Button x:Name = "Button4" Height = "75" Width = "75" Content = '4' ToolTip = "Button4"
            Canvas.Left = '50' Canvas.Top = '320' Tag = '4'/>
            <Button x:Name = "Button5" Height = "75" Width = "75" Content = '5' ToolTip = "Button5"
            Canvas.Left = '130' Canvas.Top = '320' Tag = '5'/>
            <Button x:Name = "Button6" Height = "75" Width = "75" Content = '6' ToolTip = "Button6"
            Canvas.Left = '210' Canvas.Top = '320' Tag = '6'/>

            <Button x:Name = "Button7" Height = "75" Width = "75" Content = '7' ToolTip = "Button7"
            Canvas.Left = '50' Canvas.Top = '240' Tag = '7'/>
            <Button x:Name = "Button8" Height = "75" Width = "75" Content = '8' ToolTip = "Button8"
            Canvas.Left = '130' Canvas.Top = '240' Tag = '8'/>
            <Button x:Name = "Button9" Height = "75" Width = "75" Content = '9' ToolTip = "Button9"
            Canvas.Left = '210' Canvas.Top = '240' Tag = '9'/>

            <Button x:Name = "ButtonPlus" Height = "75" Width = "75" Content = '+' ToolTip = "ButtonPlus"
            Background="orange" Canvas.Left = '290' Canvas.Top = '480' Tag = '+'/>
            <Button x:Name = "ButtonLess" Height = "75" Width = "75" Content = '-' ToolTip = "ButtonLess"
            Background="orange" Canvas.Left = '290' Canvas.Top = '400' Tag = '-'/>
            <Button x:Name = "ButtonTime" Height = "75" Width = "75" Content = 'X' ToolTip = "ButtonTime"
            Background="orange" Canvas.Left = '290' Canvas.Top = '240' Tag = '*'/>
            <Button x:Name = "ButtonDiv" Height = "75" Width = "75" Content = '/' ToolTip = "ButtonDiv"
            Background="orange" Canvas.Left = '290' Canvas.Top = '320' Tag = '/'/>

            <Button x:Name = "ButtonEg" Height = "75" Width = "75" Content = '=' ToolTip = "ButtonEg"
            Background="yellow" Canvas.Left = '210' Canvas.Top = '480'/>

        </Canvas>
</Window>
"@
 
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load( $reader )

#Connect to Control ===========================================================
for($i=0;$i -le 9; $i++){
    Set-Variable -name "button$($i)" -value $Window.FindName("Button$($i)")
}

$buttonPlus = $Window.FindName("ButtonPlus")
$buttonLess = $Window.FindName("ButtonLess")
$buttonDiv = $Window.FindName("ButtonDiv")
$buttonTime = $Window.FindName("ButtonTime")
$buttonEg = $Window.FindName("ButtonEg")
$textBox = $Window.FindName("TextBox")
$canvas = $Window.FindName("Canvas")
$form = $Window.FindName("Window")


#Connect to actions ===========================================================
$canvas.Children | ForEach-Object {
    if($_.GetType().Name -eq "Button") {
        $_.Add_Click({param($sender, $e)
            $textBox.text += $sender.Tag + " "
        })
    }
}

#Equal Button
$buttonEg.Add_Click({
    try{
        $textBox.text += "= " + (Invoke-Expression $textBox.text)
    } catch {
        $textBox.text += "= Error" 
    }
})

Add-Type -AssemblyName System.Windows.Forms
$form.Add_Closing({
    Remove-Variable * -ErrorAction SilentlyContinue
})
$form.ShowDialog() | Out-Null