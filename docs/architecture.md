Se utiliza [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) desarrollada por Robert C. Martin (Tío Bob)

![clean](clean.jpg)

Sin embargo por cuestión de agilizar el desarrollo se eliminó la capa de dominio. Por lo que la capa de presentación y de datos se comunican directamente. Además se eliminaron los `casos de uso` o `services` y los `repositorios` para agruparlos en un solo concepto de `provider` que se encarga de realizar peticiones a la API y devolver los objetos de los modelos. En la siguiente sección se explica mejor esto a medida que se explica la estructura de directorios.

## Estructura de directorios

Todo el código relacionado directamente con la apliación se encuentra dentro de la carpeta `/lib`

### `/lib/main.dart`

Contiene el punto de entrada de la apliación.

### `/lib/gen`

Esta carpeta contiene el código que es generado automáticamente por [`build_runner`](https://pub.dev/packages/build_runner)

Actualmente se utiliza el paquete [`flutter_gen`](https://pub.dev/packages/flutter_gen) para generar una clase que contiene los archivos de `assets` y facilitar su acceso.

No es necesario generar nuevamente el código a menos que agregue nuevos archivos a los assets en caso de que necesite generar nuevamente el código puede hacerlo de la siguente manera:

```
make generate
```

O

```
flutter packages pub run build_runner build
```

### `/lib/app`

Este directorio contiene todo el código que se relaciona directamente con la aplicación.

### `/lib/app/theme`

Contiene la especificación de los temas utilizados en la apliación. Estilos, fuentes, colores, etc.

### `/lib/app/app.dart`

Contiene la definición del widget pricipal que es el punto de entrada y de configuración de toda la aplicación. Aquí se utilizan funciones del resto de los archivos para configurar el entorno, el storage local de la apliación (SharedPreferences), el tema de la UI, etc.

### `/lib/app/app_binding.dart`

Contiene el código para realizar la inyección de dependencias globales. Revisar la parte de la documentación de [inyección de dependencias de GetX](getx/dependency_management.md).

### `/lib/app/routes`

Este directorio contiene los archivos que se utilizan para definir las rutas de cada vista. Revisar la parte de la documentacion de [manejo de rutas de GetX](getx/route_management.md).

### `/lib/app/data`

Contiene la capa de datos de la apliación.

### `/lib/app/data/models`

Contiene los modelos. La función de cada modelo es almacenar los datos que vienen de la API. Además de las variables para almacenar los datos deben tener un método `fromJson()` para parsear el resultado devuelto por la API.

#### Ejemplo:

```dart
import 'package:cuba_pod/app/utils/utils.dart';

class PodcastModel {
  final String title;
  final String author;
  final String slug;
  final int episodesCount;
  final String image;
  final String summary;

  PodcastModel({
    required this.title,
    required this.author,
    required this.slug,
    required this.episodesCount,
    required this.image,
    required this.summary,
  });

  PodcastModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        author = json['author'] ?? '',
        slug = json['slug'] ?? '',
        episodesCount = json['episodesCount'] ?? 0,
        image = json['image'] ?? '',
        summary = removeAllHtmlTags(json['summary'] ?? '');
}
```

### `/lib/app/data/payloads`

Los payloads son solo clases auxiliares que se utilizan para representar los datos que se envían a la API, generalmente mediante peticiones POST. No es estrictamente necesario implementarlos pero se recomienda para facilitar la comprensión del código. En el caso de este proyecto la API es GraphQL por lo que se recomienda implementar un payload para cada tipo de petición (query o mutation) que se realice a la API.


#### Ejemplo

```dart
class EpisodeByPodcastQuery {
  final String podcastSlug;

  String get payload => """
  query {
    podcast(slug: "$podcastSlug") {
      episodes {
        objects {
          title
          summary
          image
          link
          slug
          enclosure
          itunesDuration
        }
      }
    }
  }
  """;

  EpisodeByPodcastQuery({
    required this.podcastSlug,
  });
}
```

### `/lib/app/data/providers`

Los providers son las clases encargadas de realizar peticiones http a la API, y además pueden almacenar información en el **local storage** y devolver información desde esta. Cada provider debe estar relacionado con una función específica generalmente con un modelo en específico. Los providers utilizan los payloads cuando necesitan enviar información a la API.

#### Ejemplo:

```dart
import 'package:cuba_pod/app/data/models/episode_model.dart';
import 'package:cuba_pod/app/data/payloads/episode_by_podcast_query.dart';
import 'package:cuba_pod/app/environment.dart';
import 'package:get/get_connect.dart';

class EpisodeProvider extends GetConnect {
  final Environment environment;

  EpisodeProvider({
    required this.environment,
  });

  @override
  void onInit() {
    httpClient.baseUrl = environment.apiUrl;
  }

  Future<List<EpisodeModel>?> getEpidoseByPodcast(String podcastSlug) async {
    final response = await post(
      '/',
      {
        'query': EpisodeByPodcastQuery(
          podcastSlug: podcastSlug,
        ).payload,
      },
    );

    if (response.statusCode == 200) {
      final episodes = response.body['data']['podcast']['episodes']['objects']
          as List<dynamic>;

      return episodes.map((e) => EpisodeModel.fromJson(e)).toList();
    }

    print(response.statusCode);
    print(response.body);
  }
}
```

### `/lib/app/data/modules`

Contiene los módulos de la app.

Cada módulo se corresponde con una característica específica de la aplicación. Y debe contener, una o varias vistas, uno o varios controladores asociados cada uno a cada vista, un binding.

Los directorios para cada tipo de componente que conforman un módulo son `views`, `controllers`, `bindings`.

En las vistas solamente debe ir lo relacionado con la UI, widgets, texto, etc. [**Revisar manejo de estados con GetX**](getx/state_management.md). El estado de la vista se maneja a través de los controladores, esto implica que no debería utilizar widgets del tipo StatefulWidget para manejar los estados y almacenar variables. Se recomienda utilizar widgets del tipo StatelessWidget o GetView para las vistas, para garantizar la legibilidad del código y la separación de vista y estado.

#### Ejemplo de módulo:

**Podcast**

`/lib/app/modules/podcast/views/podcast_view.dart`

`/lib/app/modules/podcast/controllers/podcast_controller.dart`

`/lib/app/modules/podcast/bindings/podcast_binding.dart`

El binding es el encargado de inyectar el controlador y las dependencias que necesiten ser utilizadas por el controlador. Al utilizar el widget del tipo `GetView` para las vistas automáticamente se tiene acceso al controlador correspondiente utilizando el atributo `controller`.

Esta estructura de directorios y arquitectura está basada en GetX Pattern y Clean Architecture un poco más simplificada para agilizar el desarrollo. Además se utiliza el cli de getx para generar código y la estructura de archivos. Puede optar por utilizar el cli o directamente copiar y usar como plantilla los archivos ya existentes.

[https://pub.dev/packages/get_cli/install](https://pub.dev/packages/get_cli/install)

### Más documentación

GetX Pattern: [https://kauemurakami.github.io/getx_pattern/](https://kauemurakami.github.io/getx_pattern/)

[GetX](getx/index.md)

Tutorial del Uso de get cli y GetX:

[Desarrollo rápido en Flutter con GetX](https://luis-ciber.is-a.dev/blog/2020/03/07/desarrollo-r%C3%A1pido-en-flutter-con-getx/)
