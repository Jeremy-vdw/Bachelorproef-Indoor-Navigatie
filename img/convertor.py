import tfcoreml as tf_converter
tf_converter.convert(tf_model_path = 'groot/tensorflow_groot.pb',
                     mlmodel_path = 'groot/ModelGrootTensorflow.mlmodel',
                     output_feature_names = ['final_result:0'],
                     input_name_shape_dict={"Placeholder:0": [1, 299, 299, 3]},
                     image_input_names='Placeholder:0',
                     class_labels='groot/tensorflow_groot_labels.txt',
                     red_bias=-1,
                     green_bias=-1,
                     blue_bias=-1,
                     image_scale=2.0 / 255.0
                     )