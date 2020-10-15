[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

#--- .Net methods fory hiding/showing the console in the background ---#

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}
Hide-Console

$w = [Environment]::GetFolderPath('ApplicationData')

	if (!(test-path $w'\BNSThingy')) {
		New-Item -Path $w -Name "BNSThingy" -ItemType "directory"
	}
	if (!(test-path $w'\BNSThingy\profiles')) {
		New-Item -Path $w'\BNSTHingy' -Name "profiles" -ItemType "directory"
	}

$ProgramName = "*Blade & Soul*"
$link = "https://www.bladeandsoul.com"
$install = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\*\Products\*\InstallProperties" | Where-Object { $_.getValue('DisplayName') -like $ProgramName } | Where-Object { $_.getValue('HelpLink') -like $link } | ForEach-Object { $_.getValue('InstallLocation') }
$xmlpatchfolder = [Environment]::GetFolderPath("MyDocuments") + "\BnS\patches\"
$xmladdonfolder = [Environment]::GetFolderPath("MyDocuments") + "\BnS\addons\"
$source = $install
$RunDir = "$w\BNSThingy"
$filename=".properties"
$ScriptDir = "$w\BNSThingy\$filename"

Invoke-WebRequest "https://imgur.com/Uj0O1Ux.jpg" -OutFile "$RunDir\BG.jpg"

#-------------------------------------------------------------#
#----XAML Window Design---------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:BnS_Thingy_2._0"
        mc:Ignorable="d"
        Title="BnS Thingy" Height="585" Width="1040" WindowStyle="None" ResizeMode="NoResize" AllowsTransparency="True" Background="Transparent">

    <Window.Resources>
        <ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
            <!-- Gradient Styles for Buttons -->
            <LinearGradientBrush x:Key="ButtonBackground" StartPoint="0,0" EndPoint="0,1">
                <GradientStop Color="#FF3B679E" Offset="0"/>
                <GradientStop Color="#FF4C86BB" Offset="1"/>
            </LinearGradientBrush>

            <LinearGradientBrush x:Key="ButtonBackgroundPress" StartPoint="0,0" EndPoint="0,1">
                <GradientStop Color="#FF315685" Offset="0"/>
                <GradientStop Color="#FF315685" Offset="1"/>
            </LinearGradientBrush>

            <LinearGradientBrush x:Key="ButtonBackgroundOver" StartPoint="0,0" EndPoint="0,1">
                <GradientStop Color="#FF203857" Offset="0"/>
                <GradientStop Color="#FF294970" Offset="1"/>
            </LinearGradientBrush>

            <!-- Template for ComboBox Button -->
            <ControlTemplate x:Key="ComboBoxToggleButton" TargetType="{x:Type ToggleButton}">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition />
                        <ColumnDefinition Width="28" />
                    </Grid.ColumnDefinitions>
                    <Border x:Name="Border" Grid.ColumnSpan="2" CornerRadius="1" BorderThickness="1" BorderBrush="#FF4C86BB" Background="{StaticResource ButtonBackground}" Margin="172,0,0,0"/>
                    <Border x:Name="BorderPressed" Grid.ColumnSpan="2" CornerRadius="1" BorderThickness="1" BorderBrush="#FF315685" Opacity="0" Background="{StaticResource ButtonBackgroundPress}" Margin="172,0,0,0"/>
                    <Border x:Name="BorderOver" Grid.ColumnSpan="2" CornerRadius="1" BorderThickness="1" BorderBrush="#FF294970" Opacity="0" Background="{StaticResource ButtonBackgroundOver}" Margin="172,0,0,0"/>
                    <Border Grid.Column="0" CornerRadius="0" Margin="0,0,5,0" Opacity="0.8" Background="#FF141E29" BorderBrush="#FF363A3B" BorderThickness="1,1,1,1" />
                    <Path x:Name="Arrow" Grid.Column="1" Width="12" Stretch="Uniform" Opacity="0.8" Fill="White" Margin="0,2,0,0" HorizontalAlignment="Center" VerticalAlignment="Center" Data="M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z" />
                </Grid>
                <ControlTemplate.Triggers>
                    <Trigger Property="ToggleButton.IsMouseOver" Value="true">
                        <Trigger.EnterActions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <DoubleAnimation Storyboard.TargetName="BorderOver" Storyboard.TargetProperty="Opacity" To="0.3" Duration="0:0:0.2"/>
                                </Storyboard>
                            </BeginStoryboard>
                        </Trigger.EnterActions>
                        <Trigger.ExitActions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <DoubleAnimation Storyboard.TargetName="BorderOver" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.2"/>
                                </Storyboard>
                            </BeginStoryboard>
                        </Trigger.ExitActions>
                    </Trigger>
                    <Trigger Property="ToggleButton.IsChecked" Value="true">
                        <Trigger.EnterActions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <DoubleAnimation Storyboard.TargetName="BorderPressed" Storyboard.TargetProperty="Opacity" To="0.7" Duration="0:0:0.2"/>
                                </Storyboard>
                            </BeginStoryboard>
                        </Trigger.EnterActions>
                        <Trigger.ExitActions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <DoubleAnimation Storyboard.TargetName="BorderPressed" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.2"/>
                                </Storyboard>
                            </BeginStoryboard>
                        </Trigger.ExitActions>
                    </Trigger>
                    <Trigger Property="IsEnabled" Value="False">
                        <Setter TargetName="Border" Property="Background" Value="#EEEEEE" />
                        <Setter TargetName="Border" Property="BorderBrush" Value="#AAAAAA" />
                        <Setter Property="Foreground" Value="#888888"/>
                        <Setter TargetName="Arrow" Property="Fill" Value="#888888" />
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>

            <!-- Template ComboBox Focusable -->
            <ControlTemplate x:Key="ComboBoxTextBox" TargetType="{x:Type TextBox}">
                <Border x:Name="PART_ContentHost" Focusable="False" Background="{TemplateBinding Background}" />
            </ControlTemplate>

            <!-- Style for ComboBox -->
            <Style x:Key="{x:Type ComboBox}" TargetType="{x:Type ComboBox}">
                <Setter Property="SnapsToDevicePixels" Value="true"/>
                <Setter Property="OverridesDefaultStyle" Value="true"/>
                <Setter Property="ScrollViewer.HorizontalScrollBarVisibility" Value="Auto"/>
                <Setter Property="ScrollViewer.VerticalScrollBarVisibility" Value="Auto"/>
                <Setter Property="ScrollViewer.CanContentScroll" Value="true"/>
                <Setter Property="MinWidth" Value="120"/>
                <Setter Property="MinHeight" Value="20"/>
                <Setter Property="Foreground" Value="White"/>
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type ComboBox}">
                            <Grid>
                                <ToggleButton Name="ToggleButton" Template="{StaticResource ComboBoxToggleButton}" Grid.Column="2" Focusable="false" IsChecked="{Binding Path=IsDropDownOpen,Mode=TwoWay,RelativeSource={RelativeSource TemplatedParent}}" ClickMode="Press" />
                                <ContentPresenter Name="ContentSite" IsHitTestVisible="False"  Content="{TemplateBinding SelectionBoxItem}" ContentTemplate="{TemplateBinding SelectionBoxItemTemplate}" ContentTemplateSelector="{TemplateBinding ItemTemplateSelector}" Margin="28,5,5,6" Opacity="0.7" VerticalAlignment="Center" HorizontalAlignment="Left" />
                                <TextBox x:Name="PART_EditableTextBox" Style="{x:Null}" Template="{StaticResource ComboBoxTextBox}" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="3,3,23,3" Focusable="True" Background="#FF3F3F3F" Foreground="Green" Visibility="Hidden" IsReadOnly="{TemplateBinding IsReadOnly}"/>
                                <Popup Name="Popup" Placement="Bottom" IsOpen="{TemplateBinding IsDropDownOpen}" AllowsTransparency="True" Focusable="False" PopupAnimation="Slide">
                                    <Grid Name="DropDown" SnapsToDevicePixels="True" MinWidth="{TemplateBinding ActualWidth}" MaxHeight="{TemplateBinding MaxDropDownHeight}">
                                        <Border x:Name="DropDownBorder" Background="#FF141E29" Opacity="0.8" CornerRadius="1" BorderThickness="1" BorderBrush="#FF363A3B"/>
                                        <ScrollViewer Margin="4,6,4,6" SnapsToDevicePixels="True">
                                            <StackPanel IsItemsHost="True" KeyboardNavigation.DirectionalNavigation="Contained" />
                                        </ScrollViewer>
                                    </Grid>
                                </Popup>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="HasItems" Value="false">
                                    <Setter TargetName="DropDownBorder" Property="MinHeight" Value="95"/>
                                </Trigger>
                                <Trigger Property="IsEnabled" Value="false">
                                    <Setter Property="Foreground" Value="#888888"/>
                                </Trigger>
                                <Trigger Property="IsGrouping" Value="true">
                                    <Setter Property="ScrollViewer.CanContentScroll" Value="false"/>
                                </Trigger>
                                <Trigger SourceName="Popup" Property="Popup.AllowsTransparency" Value="true">
                                    <Setter TargetName="DropDownBorder" Property="CornerRadius" Value="0"/>
                                    <Setter TargetName="DropDownBorder" Property="Margin" Value="0,2,0,0"/>
                                </Trigger>
                                <Trigger Property="IsEditable"  Value="true">
                                    <Setter Property="IsTabStop" Value="false"/>
                                    <Setter TargetName="PART_EditableTextBox" Property="Visibility" Value="Visible"/>
                                    <Setter TargetName="ContentSite" Property="Visibility" Value="Hidden"/>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- SimpleStyles: ComboBoxItem -->
            <Style x:Key="{x:Type ComboBoxItem}" TargetType="{x:Type ComboBoxItem}">
                <Setter Property="SnapsToDevicePixels" Value="true"/>
                <Setter Property="Foreground" Value="White"/>
                <Setter Property="OverridesDefaultStyle" Value="true"/>
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type ComboBoxItem}">
                            <Border Name="Border" Padding="2" SnapsToDevicePixels="true">
                                <ContentPresenter />
                            </Border>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsHighlighted" Value="true">
                                    <Setter TargetName="Border" Property="Opacity" Value="0.7"/>
                                    <Setter TargetName="Border" Property="Background" Value="#FF141E29"/>
                                </Trigger>
                                <Trigger Property="IsEnabled" Value="false">
                                    <Setter Property="Foreground" Value="#888888"/>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Buttons -->
            <Style x:Key="SimpleButtonStyle" TargetType="{x:Type Button}">
                <Setter Property="Foreground" Value="White" />
                <Setter Property="FontFamily" Value="Segoe UI Semibold"/>
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type Button}">
                            <Grid>
                                <Border Background="{StaticResource ButtonBackground}" VerticalAlignment="Stretch" BorderThickness="1" BorderBrush="#FF4C85BA" CornerRadius="1" HorizontalAlignment="Stretch"/>
                                <Border x:Name="BorderPressed"  Opacity="0" Background="{StaticResource ButtonBackgroundPress}" VerticalAlignment="Stretch" CornerRadius="1" HorizontalAlignment="Stretch"/>
                                <Border x:Name="BorderOver"  Opacity="0" Background="{StaticResource ButtonBackgroundOver}" VerticalAlignment="Stretch" CornerRadius="1" HorizontalAlignment="Stretch"/>
                                <ContentPresenter VerticalAlignment="Center" HorizontalAlignment="Center" x:Name="MainContent" Margin="0,-1,0,0" />
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetName="BorderOver" Storyboard.TargetProperty="Opacity" To="0.3" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetName="BorderOver" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                                <Trigger Property="IsPressed" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetName="BorderPressed" Storyboard.TargetProperty="Opacity" To="0.7" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetName="BorderPressed" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for CheckBoxes -->
            <Style TargetType="CheckBox">
                <Setter Property="Foreground" Value="White"/>
                <Setter Property="FontFamily" Value="Segoe UI Semibold"/>
                <Setter Property="FontSize" Value="11" />
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="CheckBox">
                            <StackPanel Orientation="Horizontal">
                                <Grid >
                                    <Border Width="16" Height="4" Background="#FF141E29" Opacity="0.8" CornerRadius="2" Margin="0,0" />
                                    <Border x:Name="button" Height="12" Width="8" CornerRadius="1.5" HorizontalAlignment="Left" Margin="0,0" />
                                </Grid>
                                <ContentPresenter x:Name="content" Opacity="0.8" Margin="4,-1,0,0" Content="{TemplateBinding Content}" VerticalAlignment="Center" HorizontalAlignment="Left" />
                            </StackPanel>
                            <ControlTemplate.Resources>
                                <Storyboard x:Key="right">
                                    <ThicknessAnimation Storyboard.TargetProperty="Margin" Storyboard.TargetName="button" Duration="0:0:0.4" From="0,0,0,0" To="8,0,0,0" >
                                        <ThicknessAnimation.EasingFunction>
                                            <CircleEase EasingMode="EaseOut"/>
                                        </ThicknessAnimation.EasingFunction>
                                    </ThicknessAnimation>
                                </Storyboard>
                                <Storyboard x:Key="left">
                                    <ThicknessAnimation Storyboard.TargetProperty="Margin" Storyboard.TargetName="button" Duration="0:0:0.4" From="8,0,0,0" To="0,0,0,0" >
                                        <ThicknessAnimation.EasingFunction>
                                            <CircleEase EasingMode="EaseOut"/>
                                        </ThicknessAnimation.EasingFunction>
                                    </ThicknessAnimation>
                                </Storyboard>
                            </ControlTemplate.Resources>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsChecked" Value="false">
                                    <Trigger.ExitActions>
                                        <RemoveStoryboard BeginStoryboardName="leftt"></RemoveStoryboard>
                                        <BeginStoryboard Storyboard="{StaticResource right}" x:Name="rightt" ></BeginStoryboard>
                                    </Trigger.ExitActions>
                                    <Setter TargetName="button" Property="Background" Value="#FF5C6873"></Setter>
                                </Trigger>
                                <Trigger Property="IsChecked" Value="true">
                                    <Trigger.ExitActions>
                                        <RemoveStoryboard BeginStoryboardName="rightt"></RemoveStoryboard>
                                        <BeginStoryboard Storyboard="{StaticResource left}" x:Name="leftt" ></BeginStoryboard>
                                    </Trigger.ExitActions>
                                    <Setter TargetName="button" Property="Background" Value="#FFFFFFFF"></Setter>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Close Button -->
            <Style x:Key="CloseButton" TargetType="{x:Type Button}">
                <Setter Property="SnapsToDevicePixels" Value="True"/>
                <Setter Property="OverridesDefaultStyle" Value="True"/>
                <Setter Property="Opacity" Value="0.8"/>
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type Button}">
                            <Grid>
                                <Border Background="Transparent"/>
                                <Path Stretch="Uniform" Fill="#FFFFFFFF" Data="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z"/>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.55" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.8" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Minimize Button -->
            <Style x:Key="MinimizeButton" TargetType="{x:Type Button}" BasedOn="{StaticResource CloseButton}">
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type Button}">
                            <Grid>
                                <Border Background="Transparent"/>
                                <Path Stretch="Uniform" Fill="#FFFFFFFF" Data="M35,14H4V10H35" VerticalAlignment="Bottom" HorizontalAlignment="Center"/>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.55" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.8" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for BNS Folder Button -->
            <Style x:Key="BnSButton" TargetType="{x:Type Button}" BasedOn="{StaticResource CloseButton}">
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate>
                            <Grid>
                                <Border Background="Transparent"/>
                                <Path Stretch="Uniform" Fill="#FFFFFFFF" Data="M9,3V4H4V6H5V19A2,2 0 0,0 7,21H17A2,2 0 0,0 19,19V6H20V4H15V3H9M7,6H17V19H7V6M9,8V17H11V8H9M13,8V17H15V8H13Z" VerticalAlignment="Bottom" HorizontalAlignment="Center"/>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.55" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.8" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Mod Folder Button -->
            <Style x:Key="ModButton" TargetType="{x:Type Button}" BasedOn="{StaticResource CloseButton}">
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate>
                            <Grid>
                                <Border Background="Transparent"/>
                                <Path Stretch="Uniform" Fill="#FFFFFFFF" Data="M10,4H12V6H10V4M7,3H9V5H7V3M7,6H9V8H7V6M6,8V10H4V8H6M6,5V7H4V5H6M6,2V4H4V2H6M13,22A2,2 0 0,1 11,20V10A2,2 0 0,1 13,8V7H14V4H17V7H18V8A2,2 0 0,1 20,10V20A2,2 0 0,1 18,22H13M13,10V20H18V10H13Z" VerticalAlignment="Bottom" HorizontalAlignment="Center"/>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.55" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.8" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Patch Folder Button -->
            <Style x:Key="PatchButton" TargetType="{x:Type Button}" BasedOn="{StaticResource CloseButton}">
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate>
                            <Grid>
                                <Border Background="Transparent"/>
                                <Path Stretch="Uniform" Fill="#FFFFFFFF" Data="M17.73,12L21.71,8.04C22.1,7.65 22.1,7 21.71,6.63L17.37,2.29C17,1.9 16.35,1.9 15.96,2.29L12,6.27L8,2.29C7.8,2.1 7.55,2 7.29,2C7.04,2 6.78,2.1 6.59,2.29L2.25,6.63C1.86,7 1.86,7.65 2.25,8.04L6.23,12L2.25,16C1.86,16.39 1.86,17 2.25,17.41L6.59,21.75C7,22.14 7.61,22.14 8,21.75L12,17.77L15.96,21.75C16.16,21.95 16.41,22.04 16.67,22.04C16.93,22.04 17.18,21.94 17.38,21.75L21.72,17.41C22.11,17 22.11,16.39 21.72,16L17.73,12M12,9A1,1 0 0,1 13,10A1,1 0 0,1 12,11A1,1 0 0,1 11,10A1,1 0 0,1 12,9M7.29,10.96L3.66,7.34L7.29,3.71L10.91,7.33L7.29,10.96M10,13A1,1 0 0,1 9,12A1,1 0 0,1 10,11A1,1 0 0,1 11,12A1,1 0 0,1 10,13M12,15A1,1 0 0,1 11,14A1,1 0 0,1 12,13A1,1 0 0,1 13,14A1,1 0 0,1 12,15M14,11A1,1 0 0,1 15,12A1,1 0 0,1 14,13A1,1 0 0,1 13,12A1,1 0 0,1 14,11M16.66,20.34L13.03,16.72L16.66,13.09L20.28,16.71L16.66,20.34Z" VerticalAlignment="Bottom" HorizontalAlignment="Center"/>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.55" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.8" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Addon Folder Button -->
            <Style x:Key="AddonButton" TargetType="{x:Type Button}" BasedOn="{StaticResource CloseButton}">
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate>
                            <Grid>
                                <Border Background="Transparent"/>
                                <Path Stretch="Uniform" Fill="#FFFFFFFF" Data="M22,13.5C22,15.26 20.7,16.72 19,16.96V20A2,2 0 0,1 17,22H13.2V21.7A2.7,2.7 0 0,0 10.5,19C9,19 7.8,20.21 7.8,21.7V22H4A2,2 0 0,1 2,20V16.2H2.3C3.79,16.2 5,15 5,13.5C5,12 3.79,10.8 2.3,10.8H2V7A2,2 0 0,1 4,5H7.04C7.28,3.3 8.74,2 10.5,2C12.26,2 13.72,3.3 13.96,5H17A2,2 0 0,1 19,7V10.04C20.7,10.28 22,11.74 22,13.5M17,15H18.5A1.5,1.5 0 0,0 20,13.5A1.5,1.5 0 0,0 18.5,12H17V7H12V5.5A1.5,1.5 0 0,0 10.5,4A1.5,1.5 0 0,0 9,5.5V7H4V9.12C5.76,9.8 7,11.5 7,13.5C7,15.5 5.75,17.2 4,17.88V20H6.12C6.8,18.25 8.5,17 10.5,17C12.5,17 14.2,18.25 14.88,20H17V15Z" VerticalAlignment="Bottom" HorizontalAlignment="Center"/>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.55" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Opacity" To="0.8" Duration="0:0:0.2"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Radio Button -->
            <Style x:Key="SquareRadioButton" TargetType="{x:Type RadioButton}">
                <Setter Property="Foreground" Value="White"/>
                <Setter Property="FontFamily" Value="Segoe UI Semibold"/>
                <Setter Property="FontSize" Value="11" />
                <Setter Property="SnapsToDevicePixels" Value="true" />
                <Setter Property="OverridesDefaultStyle" Value="true" />
                <Setter Property="FocusVisualStyle" Value="{DynamicResource RadioButtonFocusVisual}" />
                <Setter Property="Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type RadioButton}">
                            <BulletDecorator Background="Transparent">
                                <BulletDecorator.Bullet>
                                    <Grid Width="8" Height="12">
                                        <Border x:Name="Border" Background="#FF5C6873" CornerRadius="1.5" Margin="0" />
                                        <Border x:Name="CheckMark" Background="#FFFFFFFF" CornerRadius="1.5" Visibility="Collapsed" Margin="0" />
                                    </Grid>
                                </BulletDecorator.Bullet>
                                <VisualStateManager.VisualStateGroups>
                                    <VisualStateGroup x:Name="CommonStates">
                                        <VisualState x:Name="Normal" />
                                        <VisualState x:Name="MouseOver" />
                                        <VisualState x:Name="Pressed" />
                                        <VisualState x:Name="Disabled">
                                            <Storyboard>
                                                <ColorAnimationUsingKeyFrames Storyboard.TargetName="Border" Storyboard.TargetProperty="Stroke.Color">
                                                    <DiscreteColorKeyFrame KeyTime="0" Value="LightGray" />
                                                </ColorAnimationUsingKeyFrames>
                                                <ColorAnimationUsingKeyFrames Storyboard.TargetName="CheckMark" Storyboard.TargetProperty="Fill.Color">
                                                    <DiscreteColorKeyFrame KeyTime="0" Value="LightGray" />
                                                </ColorAnimationUsingKeyFrames>
                                            </Storyboard>
                                        </VisualState>
                                    </VisualStateGroup>
                                    <VisualStateGroup x:Name="CheckStates">
                                        <VisualState x:Name="Checked" >
                                            <Storyboard>
                                                <ObjectAnimationUsingKeyFrames Storyboard.TargetName="CheckMark" Storyboard.TargetProperty="(UIElement.Visibility)">
                                                    <DiscreteObjectKeyFrame KeyTime="0" Value="{x:Static Visibility.Visible}" />
                                                </ObjectAnimationUsingKeyFrames>
                                            </Storyboard>
                                        </VisualState>
                                        <VisualState x:Name="Unchecked" />
                                        <VisualState x:Name="Indeterminate" />
                                    </VisualStateGroup>
                                </VisualStateManager.VisualStateGroups>
                                <ContentPresenter Margin="4,-0.5,0,0" Opacity="0.8" VerticalAlignment="Top" HorizontalAlignment="Left" RecognizesAccessKey="True" />
                            </BulletDecorator>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>

            <!-- Style for Tooltip -->
            <Style x:Key="CustomTooltip" TargetType="{x:Type ToolTip}">
                <Setter Property="HorizontalOffset" Value="2" />
                <Setter Property="VerticalOffset" Value="2" />
                <Setter Property="Background" Value="#FF141E29" />
                <Setter Property="Foreground" Value="#FFFFFFFF" />
                <Setter Property="BorderBrush" Value="#FF363A3B" />
                <Setter Property="Opacity" Value="0.8" />
                <Setter Property="FontSize" Value="11" />
                <Setter Property="FontFamily" Value="Segoe UI Semibold" />
            </Style>

        </ResourceDictionary>
    </Window.Resources>

    <Grid Name="form">
        <Border CornerRadius="1">
            <Border.Background>
                <ImageBrush ImageSource="$RunDir\BG.jpg"/>
            </Border.Background>
        </Border>
        <Grid Name="TopBar" Margin="0,0,0,517" Height="68">
            <Border CornerRadius="0" Background="#FF141E29" BorderThickness="0" BorderBrush="#FF363A3B" Opacity="0.8"/>
            <Button Name="CloseForm" Style="{StaticResource CloseButton}" Height="15" Width="15" Margin="0,20,20,0" VerticalAlignment="Top" HorizontalAlignment="Right"/>
            <Button Name="MinimizeForm" Style="{StaticResource MinimizeButton}" Height="15" Width="15" Margin="0,20,46,0" VerticalAlignment="Top" HorizontalAlignment="Right" RenderTransformOrigin="1.667,-0.2"/>
            <TextBox Name="SourceInput" HorizontalAlignment="Left" Height="28" Margin="20,20,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="167" Opacity="0.7" BorderBrush="#FF363A3B" Background="#FF141E29" Padding="25,5,5,5" FontFamily="Segoe UI Semibold" FontSize="11" Foreground="#FFFFFFFF" SelectionBrush="#FF474747" />
            <Label Name="SourceLabel" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="21,22,0,0" Foreground="White" Opacity="0.8">
                <Path Width="16" Stretch="Uniform" Fill="#FFFFFFFF" Data="M12 5.69L17 10.19V18H15V12H9V18H7V10.19L12 5.69M12 3L2 12H5V20H11V14H13V20H19V12H22L12 3Z"/>
            </Label>
            <Button Name="SelectSourceButton" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="192,20,0,0" Height="28" Width="28" Style="{StaticResource SimpleButtonStyle}">
                <Path Margin="1,1,0,0" Width="18" Stretch="Uniform" Fill="#FFFFFFFF" Opacity="0.8" Data="M6.1,10L4,18V8H21A2,2 0 0,0 19,6H12L10,4H4A2,2 0 0,0 2,6V18A2,2 0 0,0 4,20H19C19.9,20 20.7,19.4 20.9,18.5L23.2,10H6.1M19,18H6L7.6,12H20.6L19,18Z"/>
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Select BNS Folder"/>
                </ToolTipService.ToolTip>
            </Button>
            <ComboBox Name ="LanguageSelection" Margin="240,20,0,0" Height="28" Width="200" VerticalAlignment="Top" HorizontalAlignment="Left">
                <ComboBoxItem Content="ENGLISH"/>
                <ComboBoxItem Content="FRENCH"/>
                <ComboBoxItem Content="GERMAN"/>
                <ComboBoxItem Content="BPORTUGUESE"/>
            </ComboBox>
            <Label Name="LanguageLabel" HorizontalAlignment="Left" Opacity="0.8" VerticalAlignment="Top" Margin="242,22,0,0" Foreground="White">
                <Path Width="16" Stretch="Uniform" Fill="#FFFFFFFF" Data="M12.87,15.07L10.33,12.56L10.36,12.53C12.1,10.59 13.34,8.36 14.07,6H17V4H10V2H8V4H1V6H12.17C11.5,7.92 10.44,9.75 9,11.35C8.07,10.32 7.3,9.19 6.69,8H4.69C5.42,9.63 6.42,11.17 7.67,12.56L2.58,17.58L4,19L9,14L12.11,17.11L12.87,15.07M18.5,10H16.5L12,22H14L15.12,19H19.87L21,22H23L18.5,10M15.88,17L17.5,12.67L19.12,17H15.88Z"/>
            </Label>
            <Button Name="BnsFButton" HorizontalAlignment="Center" Content="BNS" VerticalAlignment="Top" Margin="868,20,157,0" Height="15" Width="15" Style="{StaticResource BnSButton}" Foreground="#CCFFFFFF" >
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="BNS Folder"/>
                </ToolTipService.ToolTip>
            </Button>
            <Button Name="ModFButton" Content="Mods" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="892,20,133,0" Height="15" Width="15" Style="{StaticResource ModButton}">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Mods Folder"/>
                </ToolTipService.ToolTip>
            </Button>
            <Button Name="PluginFButton" HorizontalAlignment="Center" Content="Plugins" VerticalAlignment="Top" Margin="920,20,105,0" Height="15" Width="15" Style="{StaticResource PatchButton}" RenderTransformOrigin="0.8,1.267">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="XML Patches Folder"/>
                </ToolTipService.ToolTip>
            </Button>
            <Button Name="AddonFButton" HorizontalAlignment="Center" Content="Addons" VerticalAlignment="Top" Margin="948,20,77,0" Height="15" Width="15" Style="{StaticResource AddonButton}">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Addons Folder"/>
                </ToolTipService.ToolTip>
            </Button>
        </Grid>
        <TextBox Name="OutputBox" IsReadOnly="True"  HorizontalAlignment="Left" Height="42" Margin="20,407,0,0" BorderThickness="0" TextWrapping="Wrap" VerticalAlignment="Top" Width="1000" Opacity="0.7" BorderBrush="Transparent" Background="#FF141E29" FontSize="11" Foreground="White" SelectionBrush="Transparent" Padding="5" Visibility="Collapsed"/>
        <Grid Name="BotBar" Margin="0,480,0,0" Height="105">
            <Border CornerRadius="0" Background="#FF141E29" BorderThickness="0" BorderBrush="#FF363A3B" Opacity="0.8"/>
            <TextBox Name="UsernameInput" HorizontalAlignment="Left" VerticalAlignment="Top" Height="28" Margin="20,20,0,0" Padding="25,5,5,5" FontFamily="Segoe UI Semibold" FontSize="11" Foreground="#FFFFFFFF" TextWrapping="Wrap" Width="200" Opacity="0.7" BorderBrush="#FF363A3B" Background="#FF141E29" SelectionBrush="#FF474747">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Enter Username"/>
                </ToolTipService.ToolTip>
            </TextBox>
            <Label Name="UserLabel" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="22,21,0,0" Foreground="White" Opacity="0.8">
                <Path Width="14" Height="15" Stretch="Uniform" Fill="#FFFFFFFF" Data="M12,4A4,4 0 0,1 16,8A4,4 0 0,1 12,12A4,4 0 0,1 8,8A4,4 0 0,1 12,4M12,6A2,2 0 0,0 10,8A2,2 0 0,0 12,10A2,2 0 0,0 14,8A2,2 0 0,0 12,6M12,13C14.67,13 20,14.33 20,17V20H4V17C4,14.33 9.33,13 12,13M12,14.9C9.03,14.9 5.9,16.36 5.9,17V18.1H18.1V17C18.1,16.36 14.97,14.9 12,14.9Z"/>
            </Label>
            <PasswordBox Name="PasswordInput" HorizontalAlignment="Left" VerticalAlignment="Bottom" Height="28" Margin="20,0,0,20" Padding="25,5,5,5" FontFamily="Segoe UI Semibold" FontSize="11" Foreground="#FFFFFFFF" Width="200" Opacity="0.7" BorderBrush="#FF363A3B" Background="#FF141E29">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Enter Password"/>
                </ToolTipService.ToolTip>
            </PasswordBox>
            <Label Name="PasswordLabel" HorizontalAlignment="Left" VerticalAlignment="Bottom" Margin="22,0,0,21" Foreground="White" Opacity="0.8">
                <Path Width="13" Stretch="Uniform" Fill="#FFFFFFFF" Data="M12,17C10.89,17 10,16.1 10,15C10,13.89 10.89,13 12,13A2,2 0 0,1 14,15A2,2 0 0,1 12,17M18,20V10H6V20H18M18,8A2,2 0 0,1 20,10V20A2,2 0 0,1 18,22H6C4.89,22 4,21.1 4,20V10C4,8.89 4.89,8 6,8H7V6A5,5 0 0,1 12,1A5,5 0 0,1 17,6V8H18M12,3A3,3 0 0,0 9,6V8H15V6A3,3 0 0,0 12,3Z"/>
            </Label>
            <ComboBox Name ="ProfileSelector" Margin="240,20,0,0" Height="28" Width="200" VerticalAlignment="Top" HorizontalAlignment="Left" FontFamily="Segoe UI Semibold" FontSize="11">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Select user profile"/>
                </ToolTipService.ToolTip>
            </ComboBox>
            <Label Name="ProfileSelectorLabel" HorizontalAlignment="Left" Opacity="0.8" VerticalAlignment="Top" Margin="240,22,0,0" Foreground="White">
                <Path Width="19" Stretch="Uniform" Fill="#FFFFFFFF" Data="M11 9C11 10.66 9.66 12 8 12C6.34 12 5 10.66 5 9C5 7.34 6.34 6 8 6C9.66 6 11 7.34 11 9M14 20H2V18C2 15.79 4.69 14 8 14C11.31 14 14 15.79 14 18M7 9C7 9.55 7.45 10 8 10C8.55 10 9 9.55 9 9C9 8.45 8.55 8 8 8C7.45 8 7 8.45 7 9M4 18H12C12 16.9 10.21 16 8 16C5.79 16 4 16.9 4 18M22 12V14H13V12M22 8V10H13V8M22 4V6H13V4Z"/>
            </Label>
            <TextBox Name="NewProfileInput" HorizontalAlignment="Left" VerticalAlignment="Bottom" Height="28" Margin="240,0,0,20" Padding="25,5,5,5" FontFamily="Segoe UI Semibold" FontSize="11" Foreground="#FFFFFFFF"  TextWrapping="Wrap" Width="167" Opacity="0.7" BorderBrush="#FF363A3B" Background="#FF141E29" SelectionBrush="#FF474747">
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Enter name for a new user profile"/>
                </ToolTipService.ToolTip>
            </TextBox>
            <Label Name="NewProfileLabel" HorizontalAlignment="Left" VerticalAlignment="Bottom" Margin="240,0,0,22" Foreground="White" Opacity="0.8">
                <Path Width="19"  Stretch="Uniform" Fill="#FFFFFFFF" Data="M15,4A4,4 0 0,0 11,8A4,4 0 0,0 15,12A4,4 0 0,0 19,8A4,4 0 0,0 15,4M15,5.9C16.16,5.9 17.1,6.84 17.1,8C17.1,9.16 16.16,10.1 15,10.1A2.1,2.1 0 0,1 12.9,8A2.1,2.1 0 0,1 15,5.9M4,7V10H1V12H4V15H6V12H9V10H6V7H4M15,13C12.33,13 7,14.33 7,17V20H23V17C23,14.33 17.67,13 15,13M15,14.9C17.97,14.9 21.1,16.36 21.1,17V18.1H8.9V17C8.9,16.36 12,14.9 15,14.9Z"/>
            </Label>
            <Button Name="SaveButton" HorizontalAlignment="Left" VerticalAlignment="Bottom" Margin="412,0,0,20" Height="28" Style="{StaticResource SimpleButtonStyle}" Width="28">
                <Path Margin="0,1,0,0" Width="16" Stretch="Uniform" Fill="#FFFFFFFF" Opacity="0.75" Data="M17 3H5C3.89 3 3 3.9 3 5V19C3 20.1 3.89 21 5 21H19C20.1 21 21 20.1 21 19V7L17 3M19 19H5V5H16.17L19 7.83V19M12 12C10.34 12 9 13.34 9 15S10.34 18 12 18 15 16.66 15 15 13.66 12 12 12M6 6H15V10H6V6Z"/>
                <ToolTipService.ToolTip >
                    <ToolTip Style="{StaticResource CustomTooltip}" Content="Save New Profile"/>
                </ToolTipService.ToolTip>
            </Button>
            <Button Name="StartClient" Content="PLAY" HorizontalAlignment="Right" VerticalAlignment="Top" Margin="0,20,20,0" Width="150" Height="40" FontSize="22" Style="{StaticResource SimpleButtonStyle}"/>
            <Button Name="KillClient" Content="Kill Game" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,20,20" Width="150" Height="21" FontSize="11" Style="{StaticResource SimpleButtonStyle}"/>
            <CheckBox Name="LaunchOpt1" Content="Unattended" Margin="527,18,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16" Width="130"/>
            <CheckBox Name="LaunchOpt2" Content="No Texture Streaming" Margin="527,44,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16" Width="130"/>
            <CheckBox Name="LaunchOpt3" Content="Use all Cores" Margin="527,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="130" Height="16"/>
            <RadioButton Name="RegionSelection1" GroupName="Regions" Style="{StaticResource SquareRadioButton}" Content="EU" Margin="714,18.685,294,70.315" Height="16" Width="32"/>
            <RadioButton Name="RegionSelection0" GroupName="Regions" Style="{StaticResource SquareRadioButton}" Content="NA" Margin="751,18.685,257,70.315" Width="32" Height="16"/>
            <RadioButton Name="BitnessSelection32" GroupName="Bitness" Style="{StaticResource SquareRadioButton}" Content="32b" Margin="714,44.37,294,44.63" Height="16" Width="32"/>
            <RadioButton Name="BitnessSelection64" GroupName="Bitness" Style="{StaticResource SquareRadioButton}" Content="64b" Margin="751,44.685,257,44.315" Width="32" Height="16"/>
        </Grid>
        <Grid Name="GroupBox1" Margin="20,158.5,0,236.5" Width="320" Height="190" HorizontalAlignment="Left" VerticalAlignment="Center">
            <Border CornerRadius="2" Background="#FF141E29" BorderThickness="1" BorderBrush="#FF363A3B" Opacity="0.8" Margin="0,0,0,0"/>
            <Label Name="SkillFXLabel" Content="Skill Effects" HorizontalAlignment="Left" Margin="10,7,0,0" VerticalAlignment="Top" FontSize="14" Padding="0" FontWeight="SemiBold" Foreground="White"/>
            <CheckBox Name="CheckFXA" Content="Select All" Margin="235,9,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="75" Height="16"/>
            <CheckBox Name="CheckFXM" Content="Mixed" Margin="160,9,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="75" Height="16"/>
            <CheckBox Name="CheckFX1" Content="BM" Margin="10,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX2" Content="BM 3RD" Margin="10,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX3" Content="KFM" Margin="10,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX4" Content="KFM 3RD" Margin="10,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX5" Content="FM" Margin="10,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX6" Content="FM 3RD" Margin="10,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX7" Content="DES" Margin="10,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX8" Content="DES 3RD" Margin="10,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX9" Content="SIN" Margin="85,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX10" Content="SIN 3RD" Margin="85,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX11" Content="SUM" Margin="85,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="75" Height="16"/>
            <CheckBox Name="CheckFX12" Content="SUM 3RD" Margin="85,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="75" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX13" Content="BD" Margin="85,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX14" Content="BD 3RD" Margin="85,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX15" Content="WL" Margin="85,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX16" Content="WL 3RD" Margin="85,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX17" Content="SF" Margin="160,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX18" Content="SF 3RD" Margin="160,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX19" Content="GS" Margin="160,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX20" Content="GS 3RD" Margin="160,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16" Width="71" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX21" Content="WD" Margin="160,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX22" Content="WD 3RD" Margin="160,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX23" Content="AR" Margin="160,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX24" Content="AR 3RD" Margin="160,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckFX25" Content="AM 1ST" Margin="235,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckFX26" Content="AM 2ND" Margin="235,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
        </Grid>
        <Grid Name="GroupBox2" Margin="361,158.5,359,236.5" Width="320" Height="190" VerticalAlignment="Center">
            <Border CornerRadius="2" Background="#FF141E29" BorderThickness="1" BorderBrush="#FF363A3B" Opacity="0.8" Margin="0,0,0,0"/>
            <Label Name="SkillANLabel" Content="Skill Animations" HorizontalAlignment="Left" Margin="10,7,0,0" VerticalAlignment="Top" FontSize="14" Padding="0" FontWeight="SemiBold" Foreground="White"/>
            <CheckBox Name="CheckANA" Content="Select All" Margin="235,8,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN1" Content="BM" Margin="10,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN2" Content="BM 3RD" Margin="10,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN3" Content="KFM" Margin="10,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN4" Content="KFM 3RD" Margin="10,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN5" Content="FM" Margin="10,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN6" Content="FM 3RD" Margin="10,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN7" Content="DES" Margin="10,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN8" Content="DES 3RD" Margin="10,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN9" Content="SIN" Margin="85,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN10" Content="SIN 3RD" Margin="85,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN11" Content="SUM" Margin="85,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN12" Content="SUM 3RD" Margin="85,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16" Width="71" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN13" Content="BD" Margin="85,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN14" Content="BD 3RD" Margin="85,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN15" Content="WL" Margin="85,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN16" Content="WL 3RD" Margin="85,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN17" Content="SF" Margin="160,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN18" Content="SF 3RD" Margin="160,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN19" Content="GS" Margin="160,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN20" Content="GS 3RD" Margin="160,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16" Width="71" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN21" Content="WD" Margin="160,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN22" Content="WD 3RD" Margin="160,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN23" Content="AR" Margin="160,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN24" Content="AR 3RD" Margin="160,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16" Visibility="Collapsed"/>
            <CheckBox Name="CheckAN25" Content="AM 1ST" Margin="235,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
            <CheckBox Name="CheckAN26" Content="AM 2ND" Margin="235,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Width="69" Height="16"/>
        </Grid>
        <Grid Name="GroupBox3" Margin="0,158.5,20,236.5" Width="320" Height="190" HorizontalAlignment="Right" VerticalAlignment="Center">
            <Border CornerRadius="2" Background="#FF141E29" BorderThickness="1" BorderBrush="#FF363A3B" Opacity="0.7" Margin="0,0,0,0"/>
            <Label Name="VariousFXLable" Content="Various Extras" HorizontalAlignment="Left" Margin="10,7,0,0" VerticalAlignment="Top" FontSize="14" Padding="0" FontWeight="SemiBold" Foreground="White"/>
            <CheckBox Name="CheckEX1" Content="Loading Screens" Margin="10,31,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX2" Content="Damage Numbers" Margin="10,47,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX3" Content="Soul Effects" Margin="10,71,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX4" Content="Heart Effects" Margin="10,87,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX5" Content="Unity, Talisman Effects" Margin="10,111,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX6" Content="UI Effects" Margin="10,127,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX7" Content="MSP Effects" Margin="10,151,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
            <CheckBox Name="CheckEX8" Content="Soulburn Outfits" Margin="10,167,0,0" VerticalAlignment="Top" HorizontalAlignment="Left" Height="16"/>
        </Grid>
    </Grid>
</Window>

"@

#-------------------------------------------------------------#
#----Form Execution-------------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


# Add Icon
$Window.add_Loaded

$Window.Add_MouseLeftButtonDown({ $Window.DragMove() })

#-------------------------------------------------------------#
#----General Functions----------------------------------------#
#-------------------------------------------------------------#

#--- Check to see if .properties file exists, create it if it doesn't ---#
If (!(test-path $ScriptDir)) {
    $OutputBox.AppendText("Properties file not found, creating file...`r`n")
    New-Item $ScriptDir | out-null
    Add-Content -path $ScriptDir "source:$install`r`nprofile:`r`nregion:`r`nlang:"
}
else {
    $OutputBox.AppendText("Loading Properties...`r`n")
}

#--- Select Source folder ---#
function SelectSource {
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "$source"
    $browse.Description = "Select a directory"

    $loop = $true
    while ($loop) {
        if ($browse.ShowDialog() -eq "OK") {
            $loop = $false
            #Insert your script here
        }
        else {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if ($res -eq "Cancel") {
                return
            }
        }
    }
    $script:source = $browse.SelectedPath +"\"
    $SourceInput.text = "$source"
    $OutputBox.Text = ""
    Set-Content -Path "$ScriptDir" -Value (get-content -Path "$ScriptDir" | Select-String -Pattern 'source:' -NotMatch)
    $OutputBox.AppendText("Source directory set to: " + $source + "`r`n")
    $setsource = "source:" + $source
    Add-Content -Path "$ScriptDir" -Value $setsource
    $browse.Dispose()
}

#--- Load profiles in folder to be added to combobox ---#
$GetProfiles = (Get-ChildItem -File -Path "$RunDir\profiles").BaseName
foreach ($file in $GetProfiles)
{
    $ProfileSelector.Items.Add( $file )
}


#--- Load .properties ---#
$PropertiesReader = New-Object System.IO.StreamReader("$ScriptDir")
$PropertiesLine = 1
while (($readeachline = $PropertiesReader.ReadLine()) -ne $null) {
	# Load saved BNS Path
    if ($readeachline -match "source") {
        $startindex = 7
        $endindex = $readeachline.Length - $startindex
        $script:source = $readeachline.Substring($startindex, $endindex);	
    }
	# Load last used profile
    elseif ($readeachline -match "profile") {
        $startindex = 8
        $endindex = $readeachline.Length - $startindex
        $script:profileselected = $readeachline.Substring($startindex, $endindex);	
		$OutputBox.AppendText("BNS path loaded`r`n")
    }
	# Load saved Region
	elseif ($readeachline -match "region") {
		$startindex = 7
		$endindex = $readeachline.Length - $startindex
		$script:userregion = $readeachline.Substring($startindex, $endindex);
	}
	# Load saved Language
	elseif ($readeachline -match "lang") {
		$startindex = 5
		$endindex = $readeachline.Length - $startindex
		$script:userlang = $readeachline.Substring($startindex, $endindex);
		$OutputBox.AppendText("Login details loaded`r`n")
	}
    $PropertiesLine++
}
$PropertiesReader.Dispose()

#--- Set loaded details in Form elements ---#
$SourceInput.Text = "$source"
$ProfileSelector.SelectedIndex = $profileselected
if ($userregion -eq 'NA') {
	$RegionSelection0.IsChecked = $True
}
else {
	$RegionSelection1.IsChecked = $True
}
if ($RegionSelection0.IsChecked -and $RegionSelection0.IsChecked -eq $False) {
	$RegionSelection1.IsChecked = $True
}
$LanguageSelection.Text = "$userlang"
if ($LanguageSelection.SelectedIndex = -1) {
	$LanguageSelection.SelectedIndex = 0
}

if (($BitnessSelection32.IsChecked -eq $False) -and ($BitnessSelection64.IsChecked -eq $False)) {
	$BitnessSelection32.IsChecked = $True
}

#--- Open XML Patches folder ---#
function OpenPlugins {
	If (!(test-path $xmlpatchfolder)) {
    New-Item -Path $xmlpatchfolder -ItemType directory | out-null
	}
	Invoke-Item $xmlpatchfolder
}

#--- Open Old Addons folder ---#
function OpenAddons {
	If (!(test-path $xmladdonfolder)) {
    New-Item -Path $xmladdonfolder -ItemType directory | out-null
	}
	Invoke-Item $xmladdonfolder
}

#--- Open UPK mods folder ---#
$modfolder = $SourceInput.Text + "contents\Local\NCWEST\" + $LanguageSelection.Text + "\CookedPC\mod"
function OpenMods {
	If (!(test-path $modfolder)) {
    New-Item -Path $modfolder -ItemType directory | out-null
    #$OutputBox.AppendText("Created mod folder...`r`n")
	}
	Invoke-Item $modfolder
}

#--- Open BNS folder ---#
function OpenBNSf {
	Invoke-Item $SourceInput.Text
}

#-------------------------------------------------------------#
#----Login Functions------------------------------------------#
#-------------------------------------------------------------#

#--- Load Profiles ---#
$ProfilePath = $RunDir + "\profiles\" + $ProfileSelector.Text + ".xml"

If (test-path $ProfilePath) {
	$ProfileReader = New-Object System.IO.StreamReader("$ProfilePath")
	$ProfileLine = 1

	while (($readeachline = $ProfileReader.ReadLine()) -ne $null) {
		# Load saved Username
		if ($readeachline -match "user") {
			$startindex = 5
			$endindex = $readeachline.Length - $startindex
			$script:username = $readeachline.Substring($startindex, $endindex);
		}
		# Load saved Password
		elseif ($readeachline -match "pswrd") {
			$startindex = 6
			$endindex = $readeachline.Length - $startindex
			$script:userpass = $readeachline.Substring($startindex, $endindex);
		}
		$ProfileLine++
	}
	$ProfileReader.Dispose()
}

#--- Set loaded profile details in Form elements ---#
$UsernameInput.Text = "$username"
$PasswordInput.Password = "$userpass"

#--- Changing Login Profile --- #
function ChangedProfile {
	# Read Profiles again
	$ProfilePath = $RunDir + "\profiles\" + $ProfileSelector.SelectedValue + ".xml"
	$ProfileReader = New-Object System.IO.StreamReader("$ProfilePath")
	$ProfileLine = 1
	while (($readeachline = $ProfileReader.ReadLine()) -ne $null) {
		# Load saved Username
		if ($readeachline -match "user") {
			$startindex = 5
			$endindex = $readeachline.Length - $startindex
			$script:username = $readeachline.Substring($startindex, $endindex);
		}
		# Load saved Password
		elseif ($readeachline -match "pswrd") {
			$startindex = 6
			$endindex = $readeachline.Length - $startindex
			$script:userpass = $readeachline.Substring($startindex, $endindex);
		}
		$ProfileLine++
	}
	$UsernameInput.Text = "$username"
	$PasswordInput.Password = "$userpass"
	
	$ProfileReader.Dispose()
}

#--- Save Login Details to New profile file ---#
function SaveDetails {
    $OutputBox.Text = ""
	
	if (($NewProfileInput.Text -eq $null) -or ($NewProfileInput.Text -eq '')){
		[System.Windows.Forms.MessageBox]::Show("Please enter a name for a new profile,`ror an existing profile name to edit it")
	    #$OutputBox.Text = "Please enter a name for the new profile"
        return;
    }
	
	$NewProfile = "$RunDir" + "\profiles\" + $NewProfileInput.Text + ".xml"
	If (!(test-path $NewProfile)) {
    New-Item $NewProfile | out-null
    Add-Content -path $NewProfile "user:$PasswordInput.Password`r`npswrd:$PasswordInput.Password"
	}
	
    #Save Username
    $script:username = $UsernameInput.Text
    Set-Content -Path "$NewProfile" -Value (get-content -Path "$NewProfile" | Select-String -Pattern 'user:' -NotMatch)
    $setuser = "user:" + $username
    Add-Content -Path "$NewProfile" -Value $setuser
	#Save Password
    $script:userpass = $PasswordInput.Password
    Set-Content -Path "$NewProfile" -Value (get-content -Path "$NewProfile" | Select-String -Pattern 'pswrd:' -NotMatch)
    $setpswrd = "pswrd:" + $userpass
    Add-Content -Path "$NewProfile" -Value $setpswrd
	$OutputBox.AppendText("New profile saved`r`n")
	
	$ProfileSelector.Items.Clear()
	$GetProfiles = (Get-ChildItem -File -Path "$RunDir\profiles").BaseName
	foreach ($file in $GetProfiles)
	{
		$ProfileSelector.Items.Add( $file )
	}
	$NewProfileInput.Clear()
}

#--- Start the BnS Client ---#
function StartProcess {
	$OutputBox.Text = ""
	
	# Set region parameter
	if ($RegionSelection1.IsChecked -eq $True) {
		$loginregion = "-region:1"
	}
	else {
		$loginregion = "-region:0"
	}
	
	# Set region parameter
	if ($BitnessSelection32.IsChecked -eq $True) {
		$Client = $source + "bin\Client.exe"
	}
	else {
		$Client = $source + "bin64\Client.exe"
	}
	
	# Set Unattended parameter
	if ($LaunchOpt1.IsChecked -eq $True) {
		$Lopt1 = "-unattended"
	}
	else {
		$Lopt1 = ""
	}
	
	# Set No Texture Streaming parameter
	if ($LaunchOpt2.IsChecked -eq $True) {
		$Lopt2 = "-NOTEXTURESTREAMIN"
	}
	else {
		$Lopt2 = ""
	}
	
	# Set Use All Cores parameter
	if ($LaunchOpt3.IsChecked -eq $True) {
		$Lopt3 = "-USEALLAVAILABLECORE"
	}
	else {
		$Lopt3 = ""
	}
	
	# Set parameters
	$plugins32folder = $SourceInput.Text + "bin\plugins"
	$plugins64folder = $SourceInput.Text + "bin64\plugins"
	$loginlang = "-lang:" + $LanguageSelection.Text
	$loginuser = "-USERNAME:" + $UsernameInput.Text
	$loginpass = "-PASSWORD:" + $PasswordInput.Password
	$Params = @('/sesskey','/launchbylauncher', $loginlang, $loginregion, $Lopt1, $Lopt2, $Lopt3, $loginuser, $loginpass)
	
	# Create XML Patch Folder if it doesn't exist
	If (!(test-path "$xmlpatchfolder")) {
    New-Item -Path "$xmlpatchfolder" -ItemType directory | out-null
	}
	
	# Create bin\Plugins Folder if it doesn't exist
	If (!(test-path "$plugins32folder")) {
    New-Item -Path "$plugins32folder" -ItemType directory | out-null
	}
	
	# Create bin64\Plugins Folder if it doesn't exist
	If (!(test-path "$plugins64folder")) {
    New-Item -Path "$plugins64folder" -ItemType directory | out-null
	}

$ScriptFromGitHub = Invoke-WebRequest "https://raw.githubusercontent.com/kvy1/kiwi_installer/main/installer.ps1" -UseBasicParsing

	# Check for BNS Patch
	if (!(test-path "$plugins32folder\bnspatch.dll" -PathType Leaf)) {
		#$OutputBox.AppendText("BNS Patch missing, installing...`r`n")
		Invoke-Expression $($ScriptFromGitHub.Content)
		#$OutputBox.AppendText("BNS Patch installed`r`n")
	}
	# Check for 64 BNS Patch
	if (!(test-path "$plugins64folder\bnspatch.dll" -PathType Leaf)) {
		#$OutputBox.AppendText("BNS Patch missing, installing...`r`n")
		Invoke-Expression $($ScriptFromGitHub.Content)
		#$OutputBox.AppendText("BNS Patch installed`r`n")
	}
	
	# Start Client
	$OutputBox.AppendText("Starting Client...`r`n")
	& "$Client" $Params
	$Window.WindowState = 'Minimized'
}

#--- Kill the BnS Client process ---#
function KillProcess {
	$OutputBox.Text = ""
	
	$ErrorOccured = $false
	try { 
		$ErrorActionPreference = 'Stop'
		Stop-Process -Name "Client" -Force
	}
	catch {
		"Error occured"
		$ErrorOccured=$true
	}
	if(!$ErrorOccured) {
		# [System.Windows.Forms.MessageBox]::Show("It died")
		$OutputBox.AppendText("Killed Client`r`n")
	}
}

#-------------------------------------------------------------#
#----File Related Functions-----------------------------------#
#-------------------------------------------------------------#

#--- Game File Lists ---#
# Mixed Effects
$mixFXFiles = "00003814.upk", "00007242.upk", "00008904.upk", "00009393.upk", "00009812.upk", "00010772.upk", "00011949.upk", "00012009.upk", "00024690.upk", "00026129.upk", "00059534.upk", "00060729.upk"
# Blade Master Skill Effects
$bmFXFiles = "00010354.upk", "00013263.upk"
# Blade Master 3rd Skill Effects
$bm3FXFiles = "00060548.upk"
# Kung Fu Master Skill Effects
$kfmFXFiles = "00010771.upk", "00060549.upk"
# Kung Fu Master 3rd Skill Effects
$kfm3FXFiles = "00064821.upk"
# Force Master Skill Effects
$fmFXFiles = "00009801.upk", "00060550.upk"
# Force Master 3rd Skill Effects
$fm3FXFiles = "00072638.upk"
# Destroyer Skill Effects
$desFXFiles = "00008841.upk", "00060551.upk"
# Destroyer 3rd Skill Effects
$des3FXFiles = "00067307.upk"
# Assassin Skill Effects
$sinFXFiles = "00010504.upk", "00060553.upk"
# Assassin 3rd Skill Effects
$sin3FXFiles = "00069254.upk"
# Summoner Skill Effects
$sumFXFiles = "00006660.upk", "00010869.upk", "00060554.upk"
# Blade Dancer Skill Effects
$bdFXFiles = "00031769.upk", "00060555.upk"
# Warlock Skill Effects
$wlFXFiles = "00023411.upk", "00023412.upk", "00060556.upk"
# Soul Fighter Skill Effects
$sfFXFiles = "00034433.upk", "00060557.upk"
# Gunslinger Skill Effects
$gsFXFiles = "00007307.upk", "00060552.upk"
# Warden Skill Effects
$wdFXFiles = "00056127.upk", "00060558.upk"
# Archer Skill Effects
$arFXFiles = "00064738.upk"
# Astromancer 1st Skill Effects
$as1FXFiles = "00072639.upk"
# Astromancer 2nd Skill Effects
$as2FXFiles = "00072642.upk"
# Blade Master Skill Animations
$bmANFiles = "00007911.upk"
# Blade Master 3rd Skill Animations
$bm3ANFiles = "00056567.upk"
# Kung Fu Master Skill Animations
$kfmANFiles = "00007912.upk", "00056568.upk", "00060459.upk"
# Kung Fu Master 3rd Skill Animations
$kfm3ANFiles = "00064820.upk"
# Force Master Skill Animations
$fmANFiles = "00007913.upk", "00056569.upk"
# Force Master 3rd Skill Animations
$fm3ANFiles = "00068626.upk", "00068628.upk"
# Destroyer Skill Animations
$desANFiles = "00007914.upk", "00056570.upk"
# Destroyer 3rd Skill Animations
$des3ANFiles = "00068515.upk", "00069952.upk", "00069954.upk", "00069956.upk", "00069835.upk", "00069837.upk", "00069840.upk"
# Assassin Skill Animations
$sinANFiles = "00007916.upk", "00056572.upk"
# Assassin 3rd Skill Animations
$sin3ANFiles = "00068516.upk"
# Summoner Skill Animations
$sumANFiles = "00007917.upk", "00056573.upk"
# Blade Dancer Skill Animations
$bdANFiles = "00018601.upk", "00056574.upk"
# Warlock Skill Animations
$wlANFiles = "00023439.upk", "00056575.upk"
# Soul Fighter Skill Animations
$sfANFiles = "00034408.upk", "00056576.upk"
# Gunslinger Skill Animations
$gsANFiles = "00007915.upk", "00056571.upk"
# Warden Skill Animations
$wdANFiles = "00056126.upk", "00056566.upk", "00056577.upk"
# Archer Skill Animations
$arANFiles = "00064736.upk"
# Astromancer 1st Skill Animations
$as1ANFiles = "00069237.upk"
# Astromancer 2nd Skill Animations
$as2ANFiles = "00069238.upk"
# Soulburn Outfit
$soulburnFXFiles = "00029862.upk", "00029863.upk", "00029988.upk", "00029989.upk", "00029991.upk", "00029992.upk", "00030128.upk", "00030129.upk", "00030237.upk", "00030238.upk", "00030239.upk", "00030240.upk", "00030241.upk", "00030242.upk"
# Unity, Talisman Effects
$unitytalisFXFiles = "00061517.upk"
# Soul Effects
$soulFXFiles = "00061518.upk"
# Heart Effects
$heartFXFiles = "00009805.upk"
# UI Effects
$uiFXFiles = "00011426.upk", "00027869.upk"
# MSP Poison Effects
$mspfogFXFiles = "00020755.upk"
# Damage Numbers
$dmgNRFiles = "00010081.upk"
# Loading Screens
$loadSCRNFiles = "00009368.upk"
# Loading Screens
$load2SCRNFiles = "Loading.pkg"

#--- Set General Paths ---#
$copysrc = $SourceInput.Text + "\contents\bns\CookedPC"
$copysrcB = $SourceInput.Text + "\contents\Local\NCWEST\" + $LanguageSelection.Text + "\CookedPC"
$destination = $SourceInput.Text + "\contents\bns\CookedPC_Backup"
$destinationB = $SourceInput.Text + "\contents\Local\NCWEST\" + $LanguageSelection.Text + "\CookedPC_Backup"

#--- Look for Backup folder, create if it doesn't exist ---#
If (!(test-path $destination)) {
    New-Item -Path $destination -ItemType directory | out-null
    $OutputBox.AppendText("Created backup folder...`r`n")
}

#--- Look for game files current locations ---#
$elementchk = ""
$inBackup = @()
$inMissing = @()
$inGame = $mixFXFiles + $bmFXFiles + $bm3FXFiles + $kfmFXFiles + $kfm3FXFiles + $fmFXFiles + $fm3FXFiles + $desFXFiles + $des3FXFiles + $sinFXFiles + $sin3FXFiles + $sumFXFiles + $bdFXFiles + $wlFXFiles + $sfFXFiles + $gsFXFiles + $wdFXFiles + $arFXFiles + $as1FXFiles + $as2FXFiles + $bmANFiles + $bm3ANFiles + $kfmANFiles + $kfm3ANFiles + $fmANFiles + $fm3ANFiles + $desANFiles + $des3ANFiles + $sinANFiles + $sin3ANFiles + $sumANFiles + $bdANFiles + $wlANFiles + $sfANFiles + $gsANFiles + $wdANFiles + $arANFiles + $as1ANFiles + $as2ANFiles + $soulburnFXFiles + $unitytalisFXFiles + $soulFXFiles + $heartFXFiles + $uiFXFiles + $mspfogFXFiles + $dmgNRFiles + $loadSCRNFiles
foreach ($elementchk in $inGame) {
    if (test-path -Path $copysrc\$elementchk) {
		#$OutputBox.AppendText("")
	}
	elseif (test-path -path $destination\$elementchk) {
        $inBackup += $elementchk
		#$OutputBox.AppendText( "`r`n " + $inBackup + " is in Local CookedPC_Backup`r`n" )
	}
	elseif (test-path $copysrcB\$elementchk -PathType Leaf) {
		#$OutputBox.AppendText("")
	}
	elseif (test-path $destinationB\$elementchk -PathType Leaf) {
        $inBackup += $elementchk
		#$OutputBox.AppendText( "`r`n " + $inBackup + " is in Local CookedPC_Backup`r`n" )
	}
	else {
	$isMissing += $elementchk
	$OutputBox.AppendText("" + $isMissing + " is missing!`r`n")
	}
}

#--- Check boxes depending on files current location ---#
foreach ($elementchk in $mixFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFXM.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFXM.IsChecked = $false }
	else { $CheckFXM.IsChecked = $true }
}
foreach ($elementchk in $bmFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX1.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX1.IsChecked = $false }
	else { $CheckFX1.IsChecked = $true }
}
foreach ($elementchk in $bm3FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX2.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX2.IsChecked = $false }
	else { $CheckFX2.IsChecked = $true }
}
foreach ($elementchk in $kfmFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX3.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX3.IsChecked = $false }
	else { $CheckFX3.IsChecked = $true }
}
foreach ($elementchk in $kfm3FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX4.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX4.IsChecked = $false }
	else { $CheckFX4.IsChecked = $true }
}
foreach ($elementchk in $fmFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX5.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX5.IsChecked = $false }
	else { $CheckFX5.IsChecked = $true }
}
foreach ($elementchk in $fm3FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX6.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX6.IsChecked = $false }
	else { $CheckFX6.IsChecked = $true }
}
foreach ($elementchk in $desFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX7.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX7.IsChecked = $false }
	else { $CheckFX7.IsChecked = $true }
}
foreach ($elementchk in $des3FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX8.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX8.IsChecked = $false }
	else { $CheckFX8.IsChecked = $true }
}
foreach ($elementchk in $sinFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX9.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX9.IsChecked = $false }
	else { $CheckFX9.IsChecked = $true }
}
foreach ($elementchk in $sin3FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX10.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX10.IsChecked = $false }
	else { $CheckFX10.IsChecked = $true }
}
foreach ($elementchk in $sumFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX11.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX11.IsChecked = $false }
	else { $CheckFX11.IsChecked = $true }
}
foreach ($elementchk in $bdFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX13.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX13.IsChecked = $false }
	else { $CheckFX13.IsChecked = $true }
}
foreach ($elementchk in $wlFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX15.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX15.IsChecked = $false }
	else { $CheckFX15.IsChecked = $true }
}
foreach ($elementchk in $sfFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX17.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX17.IsChecked = $false }
	else { $CheckFX17.IsChecked = $true }
}
foreach ($elementchk in $gsFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX19.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX19.IsChecked = $false }
	else { $CheckFX19.IsChecked = $true }
}
foreach ($elementchk in $wdFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX21.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX21.IsChecked = $false }
	else { $CheckFX21.IsChecked = $true }
}
foreach ($elementchk in $arFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX23.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX23.IsChecked = $false }
	else { $CheckFX23.IsChecked = $true }
}
foreach ($elementchk in $as1FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX25.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX25.IsChecked = $false }
	else { $CheckFX25.IsChecked = $true }
}
foreach ($elementchk in $as2FXFiles) {
	if ($inBackup -contains $elementchk) { $CheckFX26.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckFX26.IsChecked = $false }
	else { $CheckFX26.IsChecked = $true }
}
foreach ($elementchk in $bmANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN1.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN1.IsChecked = $false }
	else { $CheckAN1.IsChecked = $true }
}
foreach ($elementchk in $bm3ANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN2.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN2.IsChecked = $false }
	else { $CheckAN2.IsChecked = $true }
}
foreach ($elementchk in $kfmANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN3.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN3.IsChecked = $false }
	else { $CheckAN3.IsChecked = $true }
}
foreach ($elementchk in $kfm3ANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN4.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN4.IsChecked = $false }
	else { $CheckAN4.IsChecked = $true }
}
foreach ($elementchk in $fmANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN5.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN5.IsChecked = $false }
	else { $CheckAN5.IsChecked = $true }
}
foreach ($elementchk in $fm3ANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN6.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN6.IsChecked = $false }
	else { $CheckAN6.IsChecked = $true }
}
foreach ($elementchk in $desANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN7.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN7.IsChecked = $false }
	else { $CheckAN7.IsChecked = $true }
}
foreach ($elementchk in $des3ANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN8.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN8.IsChecked = $false }
	else { $CheckAN8.IsChecked = $true }
}
foreach ($elementchk in $sinANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN9.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN9.IsChecked = $false }
	else { $CheckAN9.IsChecked = $true }
}
foreach ($elementchk in $sin3ANFiles) {
 	if ($inBackup -contains $elementchk) { $CheckAN10.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN10.IsChecked = $false }
	else { $CheckAN10.IsChecked = $true }
}
foreach ($elementchk in $sumANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN11.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN11.IsChecked = $false }
	else { $CheckAN11.IsChecked = $true }
}
foreach ($elementchk in $bdANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN13.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN13.IsChecked = $false }
	else { $CheckAN13.IsChecked = $true }
}
foreach ($elementchk in $wlANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN15.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN15.IsChecked = $false }
	else { $CheckAN15.IsChecked = $true }
}
foreach ($elementchk in $sfANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN17.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN17.IsChecked = $false }
	else { $CheckAN17.IsChecked = $true }
}
foreach ($elementchk in $gsANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN19.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN19.IsChecked = $false }
	else { $CheckAN19.IsChecked = $true }
}
foreach ($elementchk in $wdANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN21.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN21.IsChecked = $false }
	else { $CheckAN21.IsChecked = $true }
}
foreach ($elementchk in $arANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN23.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN23.IsChecked = $false }
	else { $CheckAN23.IsChecked = $true }
}
foreach ($elementchk in $as1ANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN25.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN25.IsChecked = $false }
	else { $CheckAN25.IsChecked = $true }
}
foreach ($elementchk in $as2ANFiles) {
	if ($inBackup -contains $elementchk) { $CheckAN26.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckAN26.IsChecked = $false }
	else { $CheckAN26.IsChecked = $true }
}
foreach ($elementchk in $loadSCRNFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX1.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX1.IsChecked = $false }
	else { $CheckEX1.IsChecked = $true }
}
foreach ($elementchk in $dmgNRFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX2.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX2.IsChecked = $false }
	else { $CheckEX2.IsChecked = $true }
}
foreach ($elementchk in $soulFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX3.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX3.IsChecked = $false }
	else { $CheckEX3.IsChecked = $true }
}
foreach ($elementchk in $heartFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX4.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX4.IsChecked = $false }
	else { $CheckEX4.IsChecked = $true }
}
foreach ($elementchk in $unitytalisFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX5.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX5.IsChecked = $false }
	else { $CheckEX5.IsChecked = $true }
}
foreach ($elementchk in $uiFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX6.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX6.IsChecked = $false }
    else { $CheckEX6.IsChecked = $true }
}
foreach ($elementchk in $mspfogFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX7.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX7.IsChecked = $false }
	else { $CheckEX7.IsChecked = $true }
}
foreach ($elementchk in $soulburnFXFiles) {
	if ($inBackup -contains $elementchk) { $CheckEX8.IsChecked = $false }
	elseif ($isMissing -contains $elementchk) { $CheckEX8.IsChecked = $false }
	else { $CheckEX8.IsChecked = $true }
}

#--- Set "Select All" based on current checked status ---#
$FXSelected = @($CheckFX1.IsChecked, $CheckFX2.IsChecked, $CheckFX3.IsChecked, $CheckFX4.IsChecked, $CheckFX5.IsChecked, $CheckFX6.IsChecked, $CheckFX7.IsChecked, $CheckFX8.IsChecked, $CheckFX9.IsChecked, $CheckFX10.IsChecked, $CheckFX11.IsChecked, $CheckFX13.IsChecked, $CheckFX15.IsChecked, $CheckFX17.IsChecked, $CheckFX19.IsChecked, $CheckFX21.IsChecked, $CheckFX23.IsChecked, $CheckFX25.IsChecked, $CheckFX26.IsChecked, $CheckFXM.IsChecked)
$ANSelected = @($CheckAN1.IsChecked, $CheckAN2.IsChecked, $CheckAN3.IsChecked, $CheckAN4.IsChecked, $CheckAN5.IsChecked, $CheckAN6.IsChecked, $CheckAN7.IsChecked, $CheckAN8.IsChecked, $CheckAN9.IsChecked, $CheckAN10.IsChecked, $CheckAN11.IsChecked, $CheckAN13.IsChecked, $CheckAN15.IsChecked, $CheckAN17.IsChecked, $CheckAN19.IsChecked, $CheckAN21.IsChecked, $CheckAN23.IsChecked, $CheckAN25.IsChecked, $CheckAN26.IsChecked)

if($FXSelected -notcontains ($false)) {
	$CheckFXA.IsChecked = $true
}
else {
	$CheckFXA.IsChecked = $false
}

if($ANSelected -notcontains ($false)) {
	$CheckANA.IsChecked = $true
}
else {
	$CheckANA.IsChecked = $false
}

#--- Select all Skill Effects ---#
function SelectAllFX {
	$OutputBox.AppendText("Moving Files...`r`n")
	$elementchk = ""
	$GroupFX = $CheckFX1, $CheckFX2, $CheckFX3, $CheckFX4, $CheckFX5, $CheckFX6, $CheckFX7, $CheckFX8, $CheckFX9, $CheckFX10, $CheckFX11, $CheckFX13, $CheckFX15, $CheckFX17, $CheckFX19, $CheckFX21, $CheckFX23, $CheckFX25, $CheckFX26, $CheckFXM
    if ($CheckFXA.IsChecked -eq $true) {
        Foreach ($elementchk in $GroupFX) {
			$elementchk.IsChecked = $true
        }
    }
    if ($CheckFXA.IsChecked -eq $false) {
        Foreach ($elementchk in $GroupFX) {
			$elementchk.IsChecked = $false
        }
    }
	$OutputBox.AppendText("Finished moving selected all files...`r`n")
}

#--- Select all the Skill Animations ---#
function SelectAllAN {
	$OutputBox.AppendText("Moving Files...`r`n")
	$elementchk = ""
	$GroupAN = $CheckAN1, $CheckAN2, $CheckAN3, $CheckAN4, $CheckAN5, $CheckAN6, $CheckAN7, $CheckAN8, $CheckAN9, $CheckAN10, $CheckAN11, $CheckAN13, $CheckAN15, $CheckAN17, $CheckAN19, $CheckAN21, $CheckAN23, $CheckAN25, $CheckAN26
    if ($CheckANA.IsChecked -eq $true) {
        Foreach ($elementchk in $GroupAN) {
			$elementchk.IsChecked = $true
        }
    }
    if ($CheckANA.IsChecked -eq $false) {
        Foreach ($elementchk in $GroupAN) {
			$elementchk.IsChecked = $false
        }
    }
	$OutputBox.AppendText("Finished moving selected all files...`r`n")
}

#--- Move General CookedPC Files ---#
function Filemover {
    $item = ""
    $elementchk = ""
	$count = 0
    if ($this -eq $CheckFXM) { $item = $mixFXFiles }
	elseif ($this -eq $CheckFX1) { $item = $bmFXFiles }
    elseif ($this -eq $CheckFX2) { $item = $bm3FXFiles }
    elseif ($this -eq $CheckFX3) { $item = $kfmFXFiles }
    elseif ($this -eq $CheckFX4) { $item = $kfm3FXFiles }
    elseif ($this -eq $CheckFX5) { $item = $fmFXFiles }
    elseif ($this -eq $CheckFX6) { $item = $fm3FXFiles }
    elseif ($this -eq $CheckFX7) { $item = $desFXFiles }
    elseif ($this -eq $CheckFX8) { $item = $des3FXFiles }
    elseif ($this -eq $CheckFX9) { $item = $sinFXFiles }
    elseif ($this -eq $CheckFX10) { $item = $sin3FXFiles }
    elseif ($this -eq $CheckFX11) { $item = $sumFXFiles }
    elseif ($this -eq $CheckFX13) { $item = $bdFXFiles }
    elseif ($this -eq $CheckFX15) { $item = $wlFXFiles }
    elseif ($this -eq $CheckFX17) { $item = $sfFXFiles }
    elseif ($this -eq $CheckFX19) { $item = $gsFXFiles }
    elseif ($this -eq $CheckFX21) { $item = $wdFXFiles }
    elseif ($this -eq $CheckFX23) { $item = $arFXFiles }
	elseif ($this -eq $CheckFX25) { $item = $as1FXFiles }
	elseif ($this -eq $CheckFX26) { $item = $as2FXFiles }
	elseif ($this -eq $CheckAN1) { $item = $bmANFiles }
    elseif ($this -eq $CheckAN2) { $item = $bm3ANFiles }
    elseif ($this -eq $CheckAN3) { $item = $kfmANFiles }
    elseif ($this -eq $CheckAN4) { $item = $kfm3ANFiles }
    elseif ($this -eq $CheckAN5) { $item = $fmANFiles }
    elseif ($this -eq $CheckAN6) { $item = $fm3ANFiles }
    elseif ($this -eq $CheckAN7) { $item = $desANFiles }
    elseif ($this -eq $CheckAN8) { $item = $des3ANFiles }
    elseif ($this -eq $CheckAN9) { $item = $sinANFiles }
    elseif ($this -eq $CheckAN10) { $item = $sin3ANFiles }
    elseif ($this -eq $CheckAN11) { $item = $sumANFiles }
    elseif ($this -eq $CheckAN13) { $item = $bdANFiles }
    elseif ($this -eq $CheckAN15) { $item = $wlANFiles }
    elseif ($this -eq $CheckAN17) { $item = $sfANFiles }
    elseif ($this -eq $CheckAN19) { $item = $gsANFiles }
    elseif ($this -eq $CheckAN21) { $item = $wdANFiles }
    elseif ($this -eq $CheckAN23) { $item = $arANFiles }
	elseif ($this -eq $CheckAN25) { $item = $as1ANFiles }
	elseif ($this -eq $CheckAN26) { $item = $as2ANFiles }
    elseif ($this -eq $CheckEX3) { $item = $soulFXFiles }
	elseif ($this -eq $CheckEX4) { $item = $heartFXFiles }
    elseif ($this -eq $CheckEX5) { $item = $unitytalisFXFiles }
    elseif ($this -eq $CheckEX6) { $item = $uiFXFiles }
    elseif ($this -eq $CheckEX7) { $item = $mspfogFXFiles }
	elseif ($this -eq $CheckEX8) { $item = $soulburnFXFiles }
	
	# When selection is checked, backup
    if ($this.IsChecked -eq $false) {
        foreach ($elementchk in $item) {
            Copy-Item -Path $copysrc\$elementchk -Destination $destination\$elementchk
			Remove-Item -path $copysrc\$elementchk
			$count++;
        }
    }

	# When selection is unchecked, restore
    if ($this.IsChecked -eq $true) {
        foreach ($elementchk in $item) {
		    Copy-Item -Path $destination\$elementchk -Destination $copysrc\$elementchk
			Remove-Item -path $destination\$elementchk
			$count++;
		}
    }
	#$OutputBox.Text += " " + $count + " files were copied and deleted`r`n"
}

#--- Move Local CookedPC Files ---#
function FilemoverB {

	# Look for Backup folder, create if it doesn't exist
	If (!(test-path $destinationB)) {
		New-Item -Path $destinationB -ItemType directory | out-null
		$OutputBox.AppendText("Created local backup folder...`r`n")
	}

    $item = ""
    $elementchk = ""
	$count = 0
	if ($this -eq $CheckEX1) { $item = $loadSCRNFiles, $load2SCRNFiles }
	elseif ($this -eq $CheckEX2) { $item = $dmgNRFiles }

	# When selection is checked, backup
    if ($this.IsChecked -eq $false) {
        foreach ($elementchk in $item) {
            Copy-Item -Path $copysrcB\$elementchk -Destination $destinationB\$elementchk
			Remove-Item -path $copysrcB\$elementchk
			$count++;
        }
    }

	# When selection is unchecked, restore
    if ($this.IsChecked -eq $true) {
        foreach ($elementchk in $item) {
		    Copy-Item -Path $destinationB\$elementchk -Destination $copysrcB\$elementchk
			Remove-Item -path $destinationB\$elementchk
			$count++;
		}
    }
	#$OutputBox.Text += " " + $count + " files were copied and deleted`r`n"
}

#--- Check the FileHashes during Backup and Restoration ---#
function Get-FileHash { 
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $True)]
        [Alias("PSPath", "FullName")]
        [string[]]$Path, 

        [Parameter(Position = 1)]
        [ValidateSet("MD5", "SHA1", "SHA256", "SHA384", "SHA512", "RIPEMD160")]
        [string[]]$Algorithm = "SHA256"
    )
    Process {  
        ForEach ($item in $Path) { 
            $item = (Resolve-Path $item).ProviderPath
            If (-Not ([uri]$item).IsAbsoluteUri) {
                Write-Verbose ("{0} is not a full path, using current directory: {1}" -f $item, $pwd)
                $item = (Join-Path $pwd ($item -replace "\.\\", ""))
            }
            If (Test-Path $item -Type Container) {
                Write-Warning ("Cannot calculate hash for directory: {0}" -f $item)
                Return
            }
            $object = New-Object PSObject -Property @{ 
                Path = $item
            }
            # Open the Stream
            $stream = ([IO.StreamReader]$item).BaseStream
            foreach ($Type in $Algorithm) {                
                [string]$hash = -join ([Security.Cryptography.HashAlgorithm]::Create( $Type ).ComputeHash( $stream ) | 
                        ForEach { "{0:x2}" -f $_ })
                $null = $stream.Seek(0, 0)
                # If multiple algorithms are used, then they will be added to existing object                
                $object = Add-Member -InputObject $Object -MemberType NoteProperty -Name $Type -Value $Hash -PassThru
            }
            $object.pstypenames.insert(0, 'System.IO.FileInfo.Hash')
            # Output an object with the hash, algorithm and path
            Write-Output $object

            # Close the stream
            $stream.Close()
        }
    }
}

#--- Minimize App ---#
function MinimizeApp {
	$Window.WindowState = 'Minimized'
}

#--- Save last used Preference and Close App ---#
function CloseApp {
	
	if ($RegionSelection0.IsChecked -eq $True) {
		$userregion = "NA"
	}
	else {
		$userregion = "EU"
	}
	
	#Save Set Source Folder
	$script:usersource = $SourceInput.Text
	Set-Content -Path "$ScriptDir" -Value (get-content -Path "$ScriptDir" | Select-String -Pattern 'source:' -NotMatch)
    $OutputBox.AppendText("Source directory set to: " + $source + "`r`n")
    $setsource = "source:" + $usersource
    Add-Content -Path "$ScriptDir" -Value $setsource
	#Save Selected Profile
    $script:profileindex = $ProfileSelector.SelectedIndex
    Set-Content -Path "$ScriptDir" -Value (get-content -Path "$ScriptDir" | Select-String -Pattern 'profile:' -NotMatch)
	$setprofile = "profile:" + $profileindex
    Add-Content -Path "$ScriptDir" -Value $setprofile
	#Save Region
    Set-Content -Path "$ScriptDir" -Value (get-content -Path "$ScriptDir" | Select-String -Pattern 'region:' -NotMatch)
    $setregion = "region:" + $userregion
    Add-Content -Path "$ScriptDir" -Value $setregion
	#Save Language
    $script:userlang = $LanguageSelection.Text
    Set-Content -Path "$ScriptDir" -Value (get-content -Path "$ScriptDir" | Select-String -Pattern 'lang:' -NotMatch)
    $setlang = "lang:" + $userlang
    Add-Content -Path "$ScriptDir" -Value $setlang
	exit(1)
}

$CloseForm.Add_Click({ CloseApp $this $_})
$MinimizeForm.Add_Click({ MinimizeApp $this $_})
$SelectSourceButton.Add_Click({SelectSource $this $_})
$BnSFButton.Add_Click({OpenBNSf $this $_})
$ModFButton.Add_Click({OpenMods $this $_})
$PluginFButton.Add_Click({OpenPlugins $this $_})
$AddonFButton.Add_Click({OpenAddons $this $_})
$ProfileSelector.add_SelectionChanged({ChangedProfile $this $_})
$SaveButton.Add_Click({SaveDetails $this $_})
$StartClient.Add_Click({StartProcess $this $_})
$KillClient.Add_Click({KillProcess $this $_})
$CheckFXA.Add_Checked({SelectAllFX $this $_})
$CheckFXA.Add_Unchecked({SelectAllFX $this $_})
$CheckFXM.Add_Checked({Filemover $this $_})
$CheckFXM.Add_Unchecked({Filemover $this $_})
$CheckFX1.Add_Checked({Filemover $this $_})
$CheckFX1.Add_Unchecked({Filemover $this $_})
$CheckFX2.Add_Checked({Filemover $this $_})
$CheckFX2.Add_Unchecked({Filemover $this $_})
$CheckFX3.Add_Checked({Filemover $this $_})
$CheckFX3.Add_Unchecked({Filemover $this $_})
$CheckFX4.Add_Checked({Filemover $this $_})
$CheckFX4.Add_Unchecked({Filemover $this $_})
$CheckFX5.Add_Checked({Filemover $this $_})
$CheckFX5.Add_Unchecked({Filemover $this $_})
$CheckFX6.Add_Checked({Filemover $this $_})
$CheckFX6.Add_Unchecked({Filemover $this $_})
$CheckFX7.Add_Checked({Filemover $this $_})
$CheckFX7.Add_Unchecked({Filemover $this $_})
$CheckFX8.Add_Checked({Filemover $this $_})
$CheckFX8.Add_Unchecked({Filemover $this $_})
$CheckFX9.Add_Checked({Filemover $this $_})
$CheckFX9.Add_Unchecked({Filemover $this $_})
$CheckFX10.Add_Checked({Filemover $this $_})
$CheckFX10.Add_Unchecked({Filemover $this $_})
$CheckFX11.Add_Checked({Filemover $this $_})
$CheckFX11.Add_Unchecked({Filemover $this $_})
$CheckFX13.Add_Checked({Filemover $this $_})
$CheckFX13.Add_Unchecked({Filemover $this $_})
$CheckFX15.Add_Checked({Filemover $this $_})
$CheckFX15.Add_Unchecked({Filemover $this $_})
$CheckFX17.Add_Checked({Filemover $this $_})
$CheckFX17.Add_Unchecked({Filemover $this $_})
$CheckFX19.Add_Checked({Filemover $this $_})
$CheckFX19.Add_Unchecked({Filemover $this $_})
$CheckFX21.Add_Checked({Filemover $this $_})
$CheckFX21.Add_Unchecked({Filemover $this $_})
$CheckFX23.Add_Checked({Filemover $this $_})
$CheckFX23.Add_Unchecked({Filemover $this $_})
$CheckFX25.Add_Checked({Filemover $this $_})
$CheckFX25.Add_Unchecked({Filemover $this $_})
$CheckFX26.Add_Checked({Filemover $this $_})
$CheckFX26.Add_Unchecked({Filemover $this $_})
$CheckANA.Add_Checked({SelectAllAN $this $_})
$CheckANA.Add_Unchecked({SelectAllAN $this $_})
$CheckAN1.Add_Checked({Filemover $this $_})
$CheckAN1.Add_Unchecked({Filemover $this $_})
$CheckAN2.Add_Checked({Filemover $this $_})
$CheckAN2.Add_Unchecked({Filemover $this $_})
$CheckAN3.Add_Checked({Filemover $this $_})
$CheckAN3.Add_Unchecked({Filemover $this $_})
$CheckAN4.Add_Checked({Filemover $this $_})
$CheckAN4.Add_Unchecked({Filemover $this $_})
$CheckAN5.Add_Checked({Filemover $this $_})
$CheckAN5.Add_Unchecked({Filemover $this $_})
$CheckAN6.Add_Checked({Filemover $this $_})
$CheckAN6.Add_Unchecked({Filemover $this $_})
$CheckAN7.Add_Checked({Filemover $this $_})
$CheckAN7.Add_Unchecked({Filemover $this $_})
$CheckAN8.Add_Checked({Filemover $this $_})
$CheckAN8.Add_Unchecked({Filemover $this $_})
$CheckAN9.Add_Checked({Filemover $this $_})
$CheckAN9.Add_Unchecked({Filemover $this $_})
$CheckAN10.Add_Checked({Filemover $this $_})
$CheckAN10.Add_Unchecked({Filemover $this $_})
$CheckAN11.Add_Checked({Filemover $this $_})
$CheckAN11.Add_Unchecked({Filemover $this $_})
$CheckAN13.Add_Checked({Filemover $this $_})
$CheckAN13.Add_Unchecked({Filemover $this $_})
$CheckAN15.Add_Checked({Filemover $this $_})
$CheckAN15.Add_Unchecked({Filemover $this $_})
$CheckAN17.Add_Checked({Filemover $this $_})
$CheckAN17.Add_Unchecked({Filemover $this $_})
$CheckAN19.Add_Checked({Filemover $this $_})
$CheckAN19.Add_Unchecked({Filemover $this $_})
$CheckAN21.Add_Checked({Filemover $this $_})
$CheckAN21.Add_Unchecked({Filemover $this $_})
$CheckAN23.Add_Checked({Filemover $this $_})
$CheckAN23.Add_Unchecked({Filemover $this $_})
$CheckAN25.Add_Checked({Filemover $this $_})
$CheckAN25.Add_Unchecked({Filemover $this $_})
$CheckAN26.Add_Checked({Filemover $this $_})
$CheckAN26.Add_Unchecked({Filemover $this $_})
$CheckEX1.Add_Checked({FilemoverB $this $_})
$CheckEX1.Add_Unchecked({FilemoverB $this $_})
$CheckEX2.Add_Checked({FilemoverB $this $_})
$CheckEX2.Add_Unchecked({FilemoverB $this $_})
$CheckEX3.Add_Checked({Filemover $this $_})
$CheckEX3.Add_Unchecked({Filemover $this $_})
$CheckEX4.Add_Checked({Filemover $this $_})
$CheckEX4.Add_Unchecked({Filemover $this $_})
$CheckEX5.Add_Checked({Filemover $this $_})
$CheckEX5.Add_Unchecked({Filemover $this $_})
$CheckEX6.Add_Checked({Filemover $this $_})
$CheckEX6.Add_Unchecked({Filemover $this $_})
$CheckEX7.Add_Checked({Filemover $this $_})
$CheckEX7.Add_Unchecked({Filemover $this $_})
$CheckEX8.Add_Checked({Filemover $this $_})
$CheckEX8.Add_Unchecked({Filemover $this $_})

$Window.ShowDialog()
