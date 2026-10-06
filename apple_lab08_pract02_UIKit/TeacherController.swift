import UIKit

class TeacherController: UIViewController,
                         UITableViewDelegate,
                         UITableViewDataSource,
                         UISearchBarDelegate {

    @IBOutlet weak var buscador: UISearchBar!
    @IBOutlet weak var tablaDocentes: UITableView!

    var docentes = [
        ("Juan Pérez", "Matemática", "JP"),
        ("Ana Gómez", "Física", "AG"),
        ("Carlos Flores", "Química", "CF"),
        ("María López", "Biología", "ML"),
        ("David Torres", "Historia", "DT"),
        ("Emily García", "Inglés", "EG"),
        ("Thomas Martínez", "Computación", "TM"),
        ("Laura Sánchez", "Arte", "LS")
    ]

    var docentesFiltrados: [(String, String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Docentes"

        docentesFiltrados = docentes

        buscador.delegate = self
        tablaDocentes.delegate = self
        tablaDocentes.dataSource = self

        tablaDocentes.rowHeight = 78
        tablaDocentes.separatorInset = UIEdgeInsets(
            top: 0,
            left: 75,
            bottom: 0,
            right: 20
        )
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return docentesFiltrados.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let celda = tableView.dequeueReusableCell(
            withIdentifier: "TeacherCell",
            for: indexPath
        )

        let docente = docentesFiltrados[indexPath.row]

        celda.contentView.subviews.forEach {
            if $0.tag >= 100 {
                $0.removeFromSuperview()
            }
        }

        let circulo = UILabel(frame: CGRect(
            x: 12,
            y: 14,
            width: 50,
            height: 50
        ))

        circulo.tag = 100
        circulo.text = docente.2
        circulo.textAlignment = .center
        circulo.font = .boldSystemFont(ofSize: 18)
        circulo.textColor = .systemBlue
        circulo.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.12)
        circulo.layer.cornerRadius = 25
        circulo.clipsToBounds = true

        let nombre = UILabel(frame: CGRect(
            x: 78,
            y: 14,
            width: 240,
            height: 25
        ))

        nombre.tag = 101
        nombre.text = docente.0
        nombre.font = .boldSystemFont(ofSize: 18)

        let especialidad = UILabel(frame: CGRect(
            x: 78,
            y: 40,
            width: 240,
            height: 22
        ))

        especialidad.tag = 102
        especialidad.text = docente.1
        especialidad.font = .systemFont(ofSize: 15)
        especialidad.textColor = .secondaryLabel

        let flecha = UILabel(frame: CGRect(
            x: celda.contentView.bounds.width - 35,
            y: 26,
            width: 20,
            height: 20
        ))

        flecha.tag = 103
        flecha.text = "▾"
        flecha.textColor = .systemGray3
        flecha.autoresizingMask = [.flexibleLeftMargin]

        celda.contentView.addSubview(circulo)
        celda.contentView.addSubview(nombre)
        celda.contentView.addSubview(especialidad)
        celda.contentView.addSubview(flecha)

        return celda
    }

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {

        if searchText.isEmpty {

            docentesFiltrados = docentes

        } else {

            docentesFiltrados = docentes.filter {

                $0.0.lowercased().contains(searchText.lowercased()) ||
                $0.1.lowercased().contains(searchText.lowercased())
            }
        }

        tablaDocentes.reloadData()
    }
}
