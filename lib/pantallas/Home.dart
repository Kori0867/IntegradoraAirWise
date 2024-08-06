import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('¡Ofertas!'), style: TextStyle(color: Colors.red),),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: _promotions.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _promotions[index];
              return Container(
                height: 136,
                margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(item.description,
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icons.shopping_cart,
                                Icons.info_outline,
                                Icons.more_vert
                              ].map((e) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(e, size: 16),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        )),
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(item.imageUrl),
                            ))),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Promotion {
  final String title;
  final String imageUrl;
  final String description;

  Promotion(
      {required this.title,
        required this.imageUrl,
        required this.description});
}

final List<Promotion> _promotions = [
  Promotion(
    title: "Paquete de 10 Conectores de Tomacorrientes",
    description: "Descuento del 20% por tiempo limitado",
    imageUrl: "lib/pantallas/imagenes/imagen1.jpg",
  ),
  Promotion(
    title: "Oferta Especial: 5 Conectores de Tomacorrientes",
    description: "Compra 4 y el quinto es gratis",
    imageUrl: "lib/pantallas/imagenes/imagen2.jpg",
  ),
  Promotion(
    title: "Conectores de Tomacorrientes de Alta Calidad",
    description: "Hasta agotar existencias",
    imageUrl: "lib/pantallas/imagenes/imagen3.jpg",
  ),
  Promotion(
    title: "Paquete Familiar: 20 Conectores de Tomacorrientes",
    description: "Descuento del 30% solo hoy",
    imageUrl: "lib/pantallas/imagenes/imagen4.jpeg",
  ),
  Promotion(
    title: "Conectores de Tomacorrientes para Exterior",
    description: "Resistentes al agua y polvo",
    imageUrl: "lib/pantallas/imagenes/imagen5.png",
  ),
  Promotion(
    title: "Conectores de Tomacorrientes con Puertos USB",
    description: "Con puerto USB incorporado",
    imageUrl: "lib/pantallas/imagenes/imagen6.jpg",
  ),
  Promotion(
    title: "Paquete de Conectores Inteligentes",
    description: "Compatible con asistentes de voz",
    imageUrl: "lib/pantallas/imagenes/imagen7.jpg",
  ),
];
