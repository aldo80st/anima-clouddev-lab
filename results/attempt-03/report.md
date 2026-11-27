# CLOUDDEV-01 — attempt-03 — informe

**Resultado: PASS (ejecución técnica) — pendiente de revisión independiente. No es aceptación.**

## Identidad y entorno
- Sesión: `session_01ASSR3nd3GRgaxWqUnRMvCX` — https://claude.ai/code/session_01ASSR3nd3GRgaxWqUnRMvCX
- Entorno: ANIMA-CLOUDDEV-D0 (anthropic_cloud, personal), `CLAUDE_CODE_REMOTE=true`
- Repositorio único adjunto: `aldo80st/anima-clouddev-lab`; SHA base `4911dc7626adc604e7956d24bcfe6236b6f81722`
- UTC: preflight 2026-11-27T00:48:25Z · descarga 00:49:01Z · fin eval 00:50:34Z
- Plataforma: Linux x86_64, 4 CPU, 15 GiB RAM, 61 GB disco disponible
- Red: limited; hosts permitidos `github.com`, `release-assets.githubusercontent.com`; gestores de paquetes OFF; 0 network secrets; 0 variables de entorno configuradas; sin setup script.

## Negativos de egress (sólo estado, sin contenido)
| Prueba | Resultado | Veredicto |
|---|---|---|
| `curl https://example.com` | http 000, exit 56 (proxy rechaza) | PASS (bloqueado) |
| `curl api.github.com/repos/octocat/Hello-World` | http 403 | PASS (denegado) |
| `gh api repos/octocat/Hello-World` | exit 1 | PASS (denegado) |
| `gh api repos/aldo80st/anima-clouddev-lab` (control positivo) | exit 0 | PASS |
| `git ls-remote github.com/octocat/Hello-World` (suplementaria) | exit 0 | Observación: lectura git pública permitida |

## Binario
- OPA v1.21.4 `opa_linux_amd64`, 64 185 386 bytes, descargado a scratch dedicado (0700).
- SHA256 `5ae411b3ae2cb093ac1f70cc20df4b372eead7be61f7de989b33a3dbd6cbe09b` = esperado = sidecar oficial `opa_linux_amd64.sha256`; verificado **antes** de `chmod`.
- `opa version`: 1.21.4, commit `05c845177c80747a2aabb607f9318f981993cc76-dirty`, go1.27.3, linux/amd64, Rego v1.
- Ejecutado con privilegios reducidos (`setpriv` uid/gid 65534).

## Casos
`opa check --strict fixtures/opa/policy.rego` → exit 0, sin salida.

| Input | Expected | Actual (`result[0].expressions[0].value`) | Exit | ms | Match |
|---|---|---|---|---|---|
| allow.json | true | true | 0 | 14 | sí |
| deny-external.json | false | false | 0 | 13 | sí |
| deny-incomplete.json | false | false | 0 | 15 | sí |

Exit 0 en los tres casos indica evaluación correcta, no decisión allow; la decisión se tomó del booleano JSON.

## Limpieza
Scratch dedicado eliminado tras la ejecución (verificado inexistente).

## Gates
CD01 coste: NOT_VERIFIED · CD02 despacho: sesión manual, no disparador nativo · CD03 ejecución cloud: PASS · CD04 binario real: PASS · CD05 seguridad: PASS con limitaciones · CD06 evidencia: PASS · CD07 revisión: PENDIENTE.

## Limitaciones
1. El contenedor corre como uid 0; se mitigó ejecutando OPA como uid 65534, pero el agente opera como root dentro del sandbox.
2. Coste incremental 0 / facturación adicional OFF no verificables desde la sesión.
3. `allow_mcp_servers=true` en el entorno; los MCP de plugins fallaron con 403 del proxy (no se usaron).
4. El proxy git permite lectura de repos públicos no adjuntos (`git ls-remote`); el alcance API sí está restringido. No se probaron escrituras a otros repos.
5. La página `expanded_assets` no contenía el digest en texto; la revalidación se hizo con el sidecar oficial `.sha256`.
6. El proceso worker de la sesión se reinició una vez durante el preflight (antes de cualquier descarga/escritura); se continuó sin reintentar pasos.
7. El entorno expone variables internas del harness (no inspeccionadas ni impresas).
8. OPA sólo acredita PDP, no enforcement productivo. Mediciones cloud no certifican recursos locales.
