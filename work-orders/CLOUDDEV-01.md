# CLOUDDEV-01 — attempt-01 (PREPARED / NOT_RUN)

Objetivo: acreditar ejecución remota real mediante OPA, datos D0. No es autorización de despacho. Gate: cuota/coste cero, facturación adicional OFF, repositorio y entorno elegibles, un único intento autorizado, exclusividad y capacidad, filtros verificados. No ejecutar antes del gate. Canal candidato: GitHub App oficial + pull_request.opened con título exacto CLOUDDEV-01 / attempt-01, draft=true, base main, autor y head específicos verificados; sin recurrencia. Deshabilitar disparador tras intento. No abrir PR disparador desde el agente.

Artefacto candidato: OPA v1.21.4 linux amd64.
URL: https://github.com/open-policy-agent/opa/releases/download/v1.21.4/opa_linux_amd64
SHA256: 5ae411b3ae2cb093ac1f70cc20df4b372eead7be61f7de989b33a3dbd6cbe09b
Fuente: https://github.com/open-policy-agent/opa/releases/expanded_assets/v1.21.4
Revalidar versión/digest oficial antes de ejecutar. Si no coincide, HOLD. No descargar ni ejecutar sin gate; sin root.

1. Registrar sesión cloud, UTC, SO/arquitectura, CPU/RAM/disco y restricciones, sin volcar env.
2. Descargar binario en scratch dedicado, verificar SHA256 antes de hacerlo ejecutable, registrar `opa version`.
3. Ejecutar `opa check --strict fixtures/opa/policy.rego` y `opa eval --format=json --data fixtures/opa/policy.rego --input fixtures/opa/<input>.json 'data.clouddev.allow'` para cada caso. Verificar booleano en JSON, exit y expected; no confundir exit 0 con decisión allow.
4. Comprobar aislamiento con configuración y negativos benignos; no intentar conectividad privada. Limpiar scratch.
5. Entregar `report.md`, `results.json` y `SHA256SUMS` en rama exclusiva de resultados autorizada. Incluir orden/attempt, sesión, SHA base, UTC, digest, versión, casos, expected/actual, logs redactados, métricas, limitaciones. No modificar main ni abrir PR con título de solicitud.
6. Revisor independiente verifica SHA y resultados. OPA sólo acredita PDP, no enforcement productivo. ACK no término. No reintentar UNKNOWN. Sin prueba de coste cero o revisión, no declarar aceptación.

CD01 cuenta/coste; CD02 despacho; CD03 ejecución cloud; CD04 binario real; CD05 seguridad; CD06 evidencia; CD07 revisión. Todos NOT_RUN salvo preparación de insumos.
