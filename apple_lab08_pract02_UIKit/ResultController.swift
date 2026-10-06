import UIKit

class ResultController: UIViewController {

    @IBOutlet weak var operacionLabel: UILabel!
    @IBOutlet weak var primerNumeroLabel: UILabel!
    @IBOutlet weak var segundoNumeroLabel: UILabel!
    @IBOutlet weak var resultadoLabel: UILabel!

    var primerNumero: Double?
    var segundoNumero: Double?
    var operacion: String?
    var resultado: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Resultado"
        actualizarDatos()
    }

    func numeroTexto(_ numero: Double) -> String {
        if numero.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(numero))
        }
        return String(numero)
    }

    func actualizarDatos() {
        guard isViewLoaded else { return }

        if let primerNumero,
           let segundoNumero,
           let operacion,
           let resultado {

            operacionLabel.text = operacion
            primerNumeroLabel.text = numeroTexto(primerNumero)
            segundoNumeroLabel.text = numeroTexto(segundoNumero)
            resultadoLabel.text = numeroTexto(resultado)

        } else {
            operacionLabel.text = "-"
            primerNumeroLabel.text = "-"
            segundoNumeroLabel.text = "-"
            resultadoLabel.text = "0"
        }
    }

    @IBAction func compartir(_ sender: UIButton) {

        guard let primerNumero,
              let segundoNumero,
              let operacion,
              let resultado else {
            return
        }

        let texto = """
        Operación: \(operacion)
        Primer número: \(numeroTexto(primerNumero))
        Segundo número: \(numeroTexto(segundoNumero))
        Resultado: \(numeroTexto(resultado))
        """

        let compartir = UIActivityViewController(activityItems: [texto], applicationActivities: nil)
        present(compartir, animated: true)
    }

    @IBAction func nuevaOperacion(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
}
