# Cloud_Resume_Infra
This repo contains the terraform files and code for the front end of my cloud resume site, including the S3 buckets, the Cloudfront Distributions, and the Route 53 records. 

## Architecture: ![image](https://user-images.githubusercontent.com/47158510/233435755-5460c85e-05f5-4dc7-a9d9-4a17a8d7005b.png)

## Future Improvements
- Improve site stylization with CSS and/or a pre-made HTML template.
- Adjust GitHub Actions to run testint on pull requests and not deploy infra changes until merged.
- Expand infra to include a "dev" environment where changes are staged prior to "prod" deployment.
