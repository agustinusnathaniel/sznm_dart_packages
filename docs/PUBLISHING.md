# Publishing to pub.dev

## Option 1: OIDC Trusted Publishing (Recommended)

This method doesn't require storing secrets and is more secure.

### Setup

1. Go to https://pub.dev
2. Click your profile → **Publishing settings**
3. Under **"Trusted publishing"**, click **"Add trusted publisher"**
4. Fill in:
   - **Repository**: `agustinusnathaniel/sznm_dart_packages`
   - **Workflow**: `release.yaml`
   - **Environment**: (leave empty)
5. Click **Save**

### Usage

The workflow will automatically authenticate using GitHub's OIDC. No additional setup needed!

---

## Option 2: Service Account Key (Legacy)

### Create Service Account

1. Go to https://pub.dev
2. Click your profile → **Publishing settings**
3. Under **"Service accounts"**, click **"Create service account"**
4. Follow the instructions to create a JSON key
5. Save the JSON key securely

### Add GitHub Secret

1. Go to your GitHub repository
2. **Settings** → **Secrets and variables** → **Actions**
3. Click **"New repository secret"**
4. Add:
   - **Name**: `PUB_DEV_CREDENTIALS`
   - **Value**: Paste the entire JSON key content

### Update Workflow

The workflow is already configured to use `PUB_DEV_CREDENTIALS` if OIDC is not available.
