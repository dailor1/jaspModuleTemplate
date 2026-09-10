import QtQuick
import JASP.Controls

Form {
    columns: 1

    VariablesForm {
        AvailableVariablesList { name: "variablesForm" }

        AssignedVariablesList {
            name: "yVariable"
            title: qsTr("Response (Y)")
            allowedColumns: ["scale"]
            maxAllowed: 1
        }

        AssignedVariablesList {
            name: "factors"
            title: qsTr("Factors (X) - Nested")
            allowedColumns: ["nominal", "ordinal"]
        }
    }
}
