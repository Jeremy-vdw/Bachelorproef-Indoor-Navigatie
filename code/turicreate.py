import turicreate as turi

url = '/Users/Jeremy/Desktop/Bachelorproef/training/data/middel'
data = turi.image_analysis.load_images(url)
labels = ['khloe', 'amber', 'sienna']

def get_label(path, labels=labels):
    for label in labels:
        if label in path:
            return label

data['label'] = data['path'].apply(get_label)

model = turi.image_classifier.create(data, target='label')

model.export_coreml('ModelMiddelTuriCreate.mlmodel')

