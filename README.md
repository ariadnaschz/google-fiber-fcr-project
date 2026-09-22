# Google Fiber: Optimización de Soporte y Resolución al Primer Contacto (FCR)

## Contexto Comercial y Académico
Este proyecto fue desarrollado como parte del Certificado de Inteligencia de Negocios de Google. El análisis se centra en resolver una ineficiencia operativa crítica en el centro de soporte técnico de Google Fiber: una baja tasa de resolución en el primer contacto (FCR) estaba generando un alto volumen de llamadas repetidas, saturando las líneas y reduciendo la rentabilidad operativa.

## Arquitectura de Datos y Metodología
El proyecto se estructuró siguiendo un pipeline de extremo a extremo, separando rigurosamente la etapa de extracción de la visualización:

Auditoría y Transformación (SQL): Se procesaron y consolidaron registros históricos de tres mercados mediante un modelado de unificación vertical. Los scripts están estructurados con sintaxis estándar para ejecutarse a preferencia del lector, ya sea en Google BigQuery o en MySQL. Se blindó la integridad del modelo forzando tipos de datos y manejando la ausencia de llamadas de seguimiento como ceros operativos para evitar la distorsión de los promedios.

Inteligencia de Negocios (Tableau): Se migró la tabla consolidada a un Dashboard Ejecutivo en Tableau, diseñado con una jerarquía de tres niveles (KPIs macro, Diagnóstico Raíz y Evolución Temporal). El diseño incorporó especificaciones corporativas de accesibilidad (tipografía de gran tamaño y tooltips descriptivos para lectores de pantalla).

## Estructura del Repositorio (Instrucciones de Despliegue)
Para garantizar la reproducibilidad técnica de este análisis, el repositorio se estructura de la siguiente manera:

```
google-fiber-fcr-project/
│
├── data/
│   ├── raw/
│   │   ├── Market_1 - market_1.csv
│   │   ├── Market_2 - market_2.csv
│   │   └── Market_3 - market_3.csv
│   │ 
│   └── processed/
│       └── tabla_informes.csv
│
├── sql/
│   ├── 01_data_consolidation.sql       
│   └── 02_data_audit.sql
│
├── dashborad/
│   └── Panel_de_control.twbx        
│
├── images/
│   ├── mercado1,2_tipo1,2,3.png   
│   ├── mes.png
│   ├── semana.png
│   └── trimestre.png
│
├── docs/
│   ├── P1. Documento de Requisitos de las Partes Interesadas.pdf    
│   ├── P2. Documento de requisitos del proyecto.pdf 
│   └── P3. Documento de Estrategia.pdf
│
└── README.md
```

* data/raw/: Contiene los tres archivos originales extraídos del sistema para cada mercado.

* data/processed/: Contiene el modelo de datos consolidado y estructurado en SQL. Nota importante: El dashboard de Tableau debe alimentarse exclusivamente del archivo alojado en este directorio para garantizar la integridad de las agregaciones.

* sql/: Aloja los scripts de consolidación (01_data_consolidation.sql) y validación analítica (02_data_audit.sql).

* dashboards/: Contiene el archivo de Tableau con las visualizaciones ejecutivas finales.

* images/: Contiene las capturas interactivas del panel.

* docs/: Almacena los documentos oficiales de planificación del proyecto (PDF), incluyendo la matriz de partes interesadas, el documento de estrategia y los requisitos técnicos del diseño.

## Funcionalidad del Panel Interactivo
El dashboard fue diseñado para que la gerencia explore los datos sin fricción técnica, integrando parámetros de temporalidad y filtros de segmentación cruzada para simular distintos escenarios operativos.

A. Granularidad Temporal Dinámica
El usuario tiene control absoluto del eje X mediante un parámetro calculado, permitiendo agrupar la saturación de llamadas para detectar patrones a corto y mediano plazo sin necesidad de recargar la información.

Vista Semanal (Micro-tendencia): Ideal para detectar picos críticos inmediatos (ej. caídas de red).
![Vista Semanal](https://github.com/ariadnaschz/google-fiber-fcr-project/blob/main/images/semana.png)

Vista Mensual (Consolidación): Suaviza el ruido diario para evaluar el rendimiento mensual del soporte.
![Vista Mensual](https://github.com/ariadnaschz/google-fiber-fcr-project/blob/main/images/mes.png)

Vista Trimestral (Macro-tendencia): Evalúa el impacto global del Q1 en los objetivos de la empresa.
![Vista Trimestral](https://github.com/ariadnaschz/google-fiber-fcr-project/blob/main/images/trimestre.png)

B. Aislamiento Quirúrgico (Filtros Cruzados)
El panel responde dinámicamente a los menús desplegables para segmentar el problema.

Simulación de Escenarios: Al aislar, por ejemplo, los Mercados 1 y 3 frente a los Problemas Tipo 1, 2 y 3 en vista semanal, los KPIs y la línea base se recalculan instantáneamente. Esto permite al director de operaciones revelar el impacto financiero y operativo de esa combinación exacta sin afectar la base de datos subyacente.
![Filtros Dinámicos Aplicados](https://github.com/ariadnaschz/google-fiber-fcr-project/blob/main/images/mercado1%2C3_tipo1%2C2%2C3.png)

## Hallazgos Estratégicos
El panel interactivo permitió fragmentar el volumen de llamadas y aislar la causa raíz de la saturación:

Aislamiento del Cuello de Botella: Se detectó que la ineficiencia no era sistémica, sino que se concentraba casi exclusivamente en el Mercado 1 por fallas de Internet/Wifi (Tipo 5), acumulando 5,969 llamadas reincidentes.

Detección de Incidente de Infraestructura: El análisis de tendencias con granularidad dinámica reveló un pico crítico de 652 llamadas repetidas en la semana del 20 de marzo. Esto redirigió la acción gerencial de "re-capacitar agentes telefónicos" a "auditar la infraestructura física de la red regional".