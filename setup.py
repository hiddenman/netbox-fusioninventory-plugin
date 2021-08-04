from setuptools import setup, find_packages


setup(
    name='netbox_fusioninventory_plugin',
    version='0.1',
    description='A Plugin for import devices from fusion inventory agent',
    url='https://gitlab.com/Milka64/netbox-fusioninventory-plugin',
    author='Michael Ricart',
    license='BSD License',
    install_requires=[
        'bs4',
        'lxml',
        ],
    packages=find_packages(),
    include_package_data=True,
)

