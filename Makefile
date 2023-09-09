# Variables
ENV_NAME = sagemaker_env

# Create the conda environment
create-env:
	@echo "Creating conda environment named $(ENV_NAME)..."
	conda create --name $(ENV_NAME) python=3.8 -y
	@echo "Environment $(ENV_NAME) created successfully!"

# Activate the conda environment
activate-env:
	@echo "Activating conda environment named $(ENV_NAME)..."
	conda activate $(ENV_NAME)

# Install necessary packages
install-packages:
	@echo "Installing necessary packages in $(ENV_NAME)..."
	conda activate $(ENV_NAME) && pip install sagemaker pandas numpy mxnet torch torchvision torchaudio

# Setup the project directory
setup-dir:
	mkdir -p data/raw data/processed data/interim notebooks src tests models
	touch data/.gitkeep notebooks/.gitkeep src/.gitkeep tests/.gitkeep models/.gitkeep

# Setup entire environment
setup: create-env activate-env install-packages setup-dir
	@echo "Environment setup complete!"

# Clean the environment
clean:
	conda deactivate
	conda remove --name $(ENV_NAME) --all -y

.PHONY: create-env activate-env install-packages setup-dir setup clean
