#!/usr/bin/env python3

# Create index for Zim notebook
# author: Harshvardhan Pandit

# Iterate through notebook directories and files
# and create an index for each level.
# Recursively create index for each directory.
# 
# Zim has a folder structure where each directory
# has a corresponding page - directory.txt
# This script will create an index inside this file.
# This process is DESTRUCTIVE and any data inside that
# file will be LOST.

# Command line argument is the path for notebook.
# This script DOES NOT CHECK if the path is a valid zim notebook.

# Layout and working
# Class Node
#       - represents a node in the tree
#       - has a print function to print itself as a tree
#       - clean will remove directory titled files and sort remaining files
#       - make_index returns an index
#       - write_index will write the index to file
# walk_tree
#       - uses os.walk to iteratively walk the folders and create nodes
    
# usage: zim_index.py [-h] [-n NOTEBOOK] [-d] [-r] [-w]
# optional arguments:
#   -h, --help        show this help message and exit
#   -n NOTEBOOK, --notebook NOTEBOOK
#             path to zim notebook
#   -d, --debug
#   -r, --reverse     sort reverse
#   -w, --write       write to file


class Node(object):
    # node
    # represents a node in the tree
    # each node is a tree, i.e. it contains sub-nodes
    # 
    # attributes:
    #       path - path of this node
    #       files - all files in this node
    #       dirs - all sub-directories in this node
    
    BASE_LEVEL = 6
    
    def __init__(self):
        # Each instance of a node has three attributes
        # path: the filepath of this node
        # dirs: sub-directories inside this node
        # files: files inside this node
        self.path = None
        self.dirs = []
        self.files = []

    def __str__(self):
        return self.path

    def print(self, level=0):
        # Pretty printing made easy
        # Will print entire node tree
        prefix = '|' + '--' * (level - 1)
        print(prefix, self.path)
        prefix = '|' + '--' * level
        if self.files:
            print(prefix, 'files:')
            for f in self.files:
                print(prefix, f.replace('_', ' '))
        if self.dirs:
            print(prefix, 'dirs:')
            for d in self.dirs:
                d.print(level + 1)

    def clean(self, reverse=False):
        # remove directory files, sort everything else
        logging.debug('{} order reverse {}'.format(self.path, reverse))
        self.remove_dir_files()
        self.dirs.sort(key=lambda n: n.path.lower())
        self.files.sort(reverse=reverse, key=lambda f: f.lower())

    def remove_dir_files(self):
        # Remove files for sub-directories
        # directory.txt
        from os.path import basename
        for d in self.dirs:
            dname = basename(d.path)
            if dname in self.files:
                self.files.remove(dname)

    def make_index(self, level=0):
        # index is of form
        # HEADING (surrounded by '=' at appropriate level)
        # 
        # files
        # directory index (recursive)
        from os.path import basename
        from os.path import join as path_join
        # Create index for current node (self)
        index = ''
        # heading / title
        index += '{s} {title} {s}\n\n'.format(
            s='=' * (Node.BASE_LEVEL - level),
            title=basename(self.path).replace('_', ' '))
        if level > 0:
            parent = ':'.join(self.path.split('/')[-1 * level:]) +':'
            logging.debug('parent: %s' % parent)
            if level > 1:
                index += '[[+{}{}]]\n'.format(parent, basename(self.path))
            else:
                index += '[[+{}]]\n'.format(basename(self.path))
        else:
            parent = ''
        # all files
        for f in self.files:
            index += '[[+{}{}]]\n'.format(parent, f)
        index += '\n'
        for d in self.dirs:
            index += d.make_index(level + 1)
        return index


    def write_index(self):
        # Writes index at directory file
        # path.txt
        from os.path import isfile
        logging.debug(self.path)
        assert isfile(self.path + '.txt')
        index = self.make_index()
        with open(self.path + '.txt', 'w') as f:
            f.write(index)
        logging.info('index written for %s' % self.path)


def walk_tree(path, reverse=False, write=False):
    logging.debug('path: %s' % path)
    node = Node()
    node.path = path
    from os import walk
    from os.path import basename
    from os.path import join as path_join
    from os.path import splitext
    for _, dirs, files in walk(path):
        for d in dirs:
            # create sub-nodes recursively
            node.dirs.append(
                walk_tree(path_join(path, d), reverse=reverse, write=write))
        # save files without extension
        node.files = [splitext(f)[0] for f in files]
        break

    node.clean(reverse=reverse)
    if write:
        node.write_index()
    # else:
    #       index = node.make_index()
    #       print(index)
    return node


if __name__ == '__main__':
    import logging
    formatter = "[%(lineno)s:%(funcName)s] %(message)s"

    import argparse
    parser = argparse.ArgumentParser(description='Zim index')
    parser.add_argument('-n', '--notebook', help='path to zim notebook')
    parser.add_argument('-d', '--debug', action='store_true')
    parser.add_argument(
        '-r', '--reverse', help='sort reverse', action='store_true')
    parser.add_argument(
        '-w', '--write', 
        help='write to file', action='store_true')
    args = parser.parse_args()
    if args.debug:
        logging.basicConfig(level=logging.DEBUG, format=formatter)
    else:
        logging.basicConfig(format=formatter)
    logging.debug('notebook: %s' % args.notebook)
    logging.debug('write-mode: %s' % args.write)
    notebook = args.notebook
    assert notebook
    from os.path import isdir
    assert isdir(notebook)
    node = walk_tree(notebook, reverse=args.reverse, write=args.write)
    if not args.write:
        print(node.make_index())
