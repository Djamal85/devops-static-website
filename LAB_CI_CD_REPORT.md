# Mini rapport CI/CD

## Objectif

Corriger et fiabiliser le pipeline GitHub Actions du projet `devops-static-website` sur la branche `main`, en ajoutant un scan de securite Trivy avant le deploiement.

## Problemes identifies

- Le workflow existant ne gerait que le build et le push Docker.
- Aucun job Trivy n'etait present avant le deploiement.
- Aucun job `deploy` n'etait defini.
- Les secrets utilises etaient `DOCKER_USERNAME` et `DOCKER_PASSWORD`, alors que le lab demande `DOCKERHUB_USERNAME` et `DOCKERHUB_TOKEN`.
- Le tag Docker etait fixe a `v1`, ce qui limitait la tracabilite.
- Le depot ne contenait pas de `Dockerfile`, donc le build Docker du workflow etait incomplet.

## Modifications apportees

- Remplacement du workflow par `.github/workflows/ci.yaml`.
- Ajout de trois jobs explicites : `build-and-push`, `scan-trivy` et `deploy`.
- Conservation du declenchement sur `push` vers `main`.
- Conservation de `workflow_dispatch` pour permettre un lancement manuel.
- Ajout d'un `Dockerfile` pour construire l'image du site statique avec Nginx.
- Passage aux secrets `DOCKERHUB_USERNAME` et `DOCKERHUB_TOKEN`.
- Ajout d'un tag image base sur `${{ github.sha }}` et d'un tag `latest`.
- Ajout d'un scan de securite avec l'action officielle `aquasecurity/trivy-action`.
- Ajout d'une validation de deploiement executable sur GitHub-hosted runner.

## Impact des changements

- Le pipeline devient coherent et complet pour un site statique conteneurise.
- Le job `deploy` ne s'execute qu'apres un build et un scan Trivy reussis.
- La tracabilite des images Docker est amelioree.
- Le workflow est compatible avec GitHub Actions standard.
- Pour un vrai deploiement persistant en production, un runner self-hosted ou un serveur distant reste necessaire.

## Livrables

- Workflow corrige : `.github/workflows/ci.yaml`
- Dockerfile ajoute : `Dockerfile`
- Branche de travail : `trivy`
- Rapport de rendu : `LAB_CI_CD_REPORT.md`
