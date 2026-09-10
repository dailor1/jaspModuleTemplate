import QtQuick
import JASP.Module

Description
{
    name:       "ccOpex"
    title:      qsTr("ccOpex")
    description:qsTr("Variability Chart")
    version:    "0.1.0"
    author:     "Whirlpool"
    maintainer: "Whirlpool"
    website:    "whirlpool.com"
    license:    "GPL-3"
    icon:       "analysis-classic-anova.svg"

    GroupTitle
    {
        title:  qsTr("Gráficos OPEX")
        icon:   "analysis-classic-anova.svg"
    }
    
    Analysis
    {
        title:  qsTr("Variability Chart")
        func:   "VariabilityChart"
    }
}
