import UIKit

class CalculatorController: UIViewController {

    @IBOutlet weak var primerNumeroTextField: UITextField!
    @IBOutlet weak var segundoNumeroTextField: UITextField!
    @IBOutlet weak var operacionButton: UIButton!

    var operacionSeleccionada = "Suma (+)"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Calculadora"
        configurarMenu()
    }

    func configurarMenu() {
        let suma = UIAction(title: "Suma (+)") { _ in
            self.operacionSeleccionada = "Suma (+)"
            self.operacionButton.setTitle("Suma (+)", for: .normal)
        }

        let resta = UIAction(title: "Resta (-)") { _ in
            self.operacionSeleccionada = "Resta (-)"
            self.operacionButton.setTitle("Resta (-)", for: .normal)
        }

        let multiplicacion = UIAction(title: "Multiplicación (×)") { _ in
            self.operacionSeleccionada = "Multiplicación (×)"
            self.operacionButton.setTitle("Multiplicación (×)", for: .normal)
        }

        operacionButton.menu = UIMenu(children: [suma, resta, multiplicacion])
        operacionButton.showsMenuAsPrimaryAction = true
    }

    @IBAction func calcular(_ sender: UIButton) {

        guard let numero1 = Double(primerNumeroTextField.text ?? ""),
              let numero2 = Double(segundoNumeroTextField.text ?? "") else {

            let alerta = UIAlertController(
                title: "Aviso",
                message: "Ingresa dos números válidos.",
                preferredStyle: .alert
            )
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alerta, animated: true)
            return
        }

        var resultado = 0.0

        switch operacionSeleccionada {
        case "Suma (+)":
            resultado = numero1 + numero2
        case "Resta (-)":
            resultado = numero1 - numero2
        case "Multiplicación (×)":
            resultado = numero1 * numero2
        default:
            break
        }

        guard let controladores = tabBarController?.viewControllers,
              controladores.count >= 3,
              let navegacion = controladores[2] as? UINavigationController,
              let resultadoController = navegacion.viewControllers.first as? ResultController else {
            return
        }

        resultadoController.primerNumero = numero1
        resultadoController.segundoNumero = numero2
        resultadoController.operacion = operacionSeleccionada
        resultadoController.resultado = resultado
        resultadoController.actualizarDatos()

        tabBarController?.selectedIndex = 2
    }
}
